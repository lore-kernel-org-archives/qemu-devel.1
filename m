Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839DEC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 08:10:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 550802065D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 08:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WU/hsFOp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 550802065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ8wO-0001d9-I1
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 04:10:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jZ8vo-0000td-5A
 for qemu-devel@nongnu.org; Thu, 14 May 2020 04:09:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20290
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jZ8vn-0004v3-FE
 for qemu-devel@nongnu.org; Thu, 14 May 2020 04:09:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589443766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SezwFbuGKZlpzcwUrZZhE7vov5K+d6pTCEXg1UOF2uA=;
 b=WU/hsFOpmRi912QtDaKzLqRtfimYmcZoMFb9IBqegHTL8PLqzPuZXJGkZ7uwueJuJwoKIP
 gr3SL031b5rV5Nwyd03yaB0dWDgIHlMgf9uSNqlOX0msmEC7ytBHUyhOhYezmrTs/Hwfgp
 ut7VNyPYDwFQ18LXZLCuWRki6XHX3hU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-cj9hyYnXMDO3i6bPSQPg5g-1; Thu, 14 May 2020 04:09:24 -0400
X-MC-Unique: cj9hyYnXMDO3i6bPSQPg5g-1
Received: by mail-wm1-f69.google.com with SMTP id w2so13101538wmc.3
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 01:09:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:from:subject:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=SezwFbuGKZlpzcwUrZZhE7vov5K+d6pTCEXg1UOF2uA=;
 b=ReSsLv7Hg0UFdrIlf5mrXM5XP0QGw7T98EBYDj5Vf7GziPGJpbyLk3ZaBLeQT0U6rv
 WcKozQX7ibcAU9lS8EMeULltLzR3hdGG51CJVsC2HPDlpmbhO+IxWfShSdQQLQh27Tgw
 s76QX1dGXiYq+i1YcSIj+9i+0YE5K4pTqOaZyVQFU6FwT5Gvu2w6Zx1rhGC9lvo+YEJV
 A7CEwF+nUXAZ2sBHVo7Dgouoqb3HCSMJYxpLJvMSAO8fXb+s3eWwMDKX5r4Vno8Xlazb
 onGpqSSjnx7MtKvQ/6akoOv1Owtz0TMw8+AM9pWYFq/GkwS+YB4g0n3s9LwS3vrj2lYM
 EB7A==
X-Gm-Message-State: AGi0Pua2WyLaCKQ1xakHOjZwcEyKe3dAcg68h7yvdYmUBrbYgKh9io9L
 IJaH2pOSrJ0KYaujrfxu+FWirPbdJoTrO59yLrT7cIazy5dmuXgwQ9gNpcCV15+VYGWNmB+Ffn0
 kaDpOKAAoNA5nVHs=
X-Received: by 2002:a7b:cd04:: with SMTP id f4mr45349695wmj.3.1589443763536;
 Thu, 14 May 2020 01:09:23 -0700 (PDT)
X-Google-Smtp-Source: APiQypK4qSyYAuxFcCZpHipcvpkqoAtt3FSSx+MP0WBsJUzjm4WMiZuiIG5DR7Gfuhu4Fw8LUWadkw==
X-Received: by 2002:a7b:cd04:: with SMTP id f4mr45349676wmj.3.1589443763332;
 Thu, 14 May 2020 01:09:23 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:bdd8:ac77:1ff4:62c6?
 ([2001:b07:6468:f312:bdd8:ac77:1ff4:62c6])
 by smtp.gmail.com with ESMTPSA id n9sm2941024wru.90.2020.05.14.01.09.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 May 2020 01:09:22 -0700 (PDT)
To: qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster
 <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 John Snow <jsnow@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: proposal: deprecate -readconfig/-writeconfig
Message-ID: <7599153e-89a2-9a86-16ad-4a3c6a107b18@redhat.com>
Date: Thu, 14 May 2020 10:09:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

IMHO configuration files are in general a failed experiment.  In
practice, they do not add much value over just a shell script because
they don't allow configuring all QEMU options, they are very much fixed
(by their nature).  I think it's more or less agreed that they are not
solving any problem for higher-level management stacks as well; those
would prefer to configure the VM via QMP or another API.

So, any objections to deprecating -readconfig and -writeconfig?

Thanks,

Paolo


