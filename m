Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F51C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 07:42:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 305A02065C
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 07:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gnIdni1G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 305A02065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZUz6-0002Jg-Cl
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 03:42:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZUy3-0001Hu-2p
 for qemu-devel@nongnu.org; Fri, 15 May 2020 03:41:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24965
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZUy1-0003f1-2O
 for qemu-devel@nongnu.org; Fri, 15 May 2020 03:41:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589528471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=R2Ge6bpoozPCMrb1cFmORwqwAftnD/V2BwcNBHdr98Q=;
 b=gnIdni1GpPUxViV/JD0x1jVZzTyu9bEE8mQDY/iz2spBLJv6n26d4/8b4z39Tku7K7dLZ8
 ky58VQF+M2UvCUskJ+omTYTuIdm9puokMR0owUuvFYfJn5T6BQFgVg6PcaPxVIfIsNphvV
 A96QuC1d/Q7YwBYhj9BH848bCfSSgXY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-_dAPe3LSMjum03oD3K2frw-1; Fri, 15 May 2020 03:41:04 -0400
X-MC-Unique: _dAPe3LSMjum03oD3K2frw-1
Received: by mail-wr1-f72.google.com with SMTP id q13so747225wrn.14
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 00:41:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:from:subject:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=R2Ge6bpoozPCMrb1cFmORwqwAftnD/V2BwcNBHdr98Q=;
 b=AlCsgQcZjCzP467197Qck/H8NZKwu+DhsGIBDYgOkeXNWP9c4thnv6l8Ht+3jG/JoZ
 1fFVXf21R+EEBxvomAWpaGySy9bY537Oc9+Vglizx8Z4IZxFaDZLEyE3yRVkBvzrzekG
 I5J30gZbsTkbxPJ0PMRXRMfSv/EDbiIlTXckV3YwlxwlrN+ejYmRLTui+4Rv6s7SFnmL
 Z3qAS/l1qx17ejEgu+LnuQSCGrJbNIjXmsDQBqi137oMW1Csexnk2DHYaMMN23gI8s4V
 Q4ze4CQIMvTKm+T+H22zwQW571CYpEehGqIpnupU2y0IShnZ14+j2ItYZ1r7L1stO9rY
 eSoQ==
X-Gm-Message-State: AOAM531qYqah1EBoo6NIwy+/FNXmyULpQkJJXko2Enq6aADk8sc+3kyk
 mpHOlFOykRghIPpqTf4nxNqIKqpItRNNPiChjgkVrOUw5mdioUpRzmLeGMpUSssAAI83+sl/OqC
 4Ca3Ch7bnod/a1Ls=
X-Received: by 2002:a05:600c:297:: with SMTP id
 23mr2683886wmk.12.1589528462995; 
 Fri, 15 May 2020 00:41:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQSCc1VGEu6p096yTWDPPSyLXoV+r0ImRGhvm8df0wTgimzhoAi92gCpgLz/GqATYfge2gZg==
X-Received: by 2002:a05:600c:297:: with SMTP id
 23mr2683869wmk.12.1589528462745; 
 Fri, 15 May 2020 00:41:02 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id x24sm2400417wrd.51.2020.05.15.00.41.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2020 00:41:02 -0700 (PDT)
To: SJTU CTF team <0ops@0ops.net>, qemu-devel <qemu-devel@nongnu.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Subject: Please disable IRC notification on HighW4y2H3ll/qemu-fuzz fork
Message-ID: <1150c529-9b40-c6f8-f35d-628549c4f470@redhat.com>
Date: Fri, 15 May 2020 09:41:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 22:56:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

your private qemu-fuzz project [1] based on old QEMU code does not 
contains the commit cb4c2536d56c [2] which disable IRC build 
notification on forks. Do you mind cherry-picking it, to avoid reporting 
your build failures on the mainstream QEMU IRC channel?

Thanks,

Phil.

[1] https://github.com/HighW4y2H3ll/qemu-fuzz/
[2] https://git.qemu.org/?p=qemu.git;a=commit;h=cb4c2536d56c


