Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8610BC43467
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 10:45:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFE5E21734
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 10:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iovow9ve"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFE5E21734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQTPx-0002Kv-P2
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 06:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQTP5-0001UZ-PU
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 06:44:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55201)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQTP2-0007Cj-0D
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 06:44:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602153842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=76ihinSyN374+NpDIL8AmtVkLaHIcLA56DV6E9NUQ4E=;
 b=Iovow9vemSUAQluiCSEm/X1wXoDx3b0BuwYbbsInfrnJq0/Df/RKiJEzndpu9AY+TV87oY
 /0i52pRLSlOxAZZWWgloPFyFsCLvDaSz9awAZHb5zXHZMJP/oljTFWCRUVNXVD4qZo8enS
 gp/XgNYJ3m+A1d4BO40i1Qmn0BaBtGM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-xZLhEkN9N_y7ViisvytmZQ-1; Thu, 08 Oct 2020 06:43:59 -0400
X-MC-Unique: xZLhEkN9N_y7ViisvytmZQ-1
Received: by mail-wm1-f71.google.com with SMTP id g125so3005603wme.1
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 03:43:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=76ihinSyN374+NpDIL8AmtVkLaHIcLA56DV6E9NUQ4E=;
 b=VTongjmGdFZclv79HmNal+oksIHudCb1tDlneebeKImABk9wXQbXl8D3LHW8LhW24h
 c4fKiJzuBSxQUAear2mTGXkqlSSkhALfV4Fugj9OBYl92mkdPv+jhaULaC4EcHQiLnL9
 0zzNv2yXHOx+Z4UVLSxVfYc7ejFG72GpE7PfE8oEdbO5BYIYN6pvb6poHy41CyrWmSFs
 DFpXNDA4wg47sCthgvpQa8XQefbMekTDeCibsaNjT2VS4aYKVp2iR5AsWokXmhtkTYIR
 e4cYMLorH9m7aYSVmTUTqsTQy13G4QV8KibbMfUwoPDoneBlFmILj0yJD6rVfpM2szwp
 NFkw==
X-Gm-Message-State: AOAM531HacJxTJM5b0Avbvz1IHeWiXzzbG6BoxIKQCPergZnYJJ8oWsr
 +fZHMlqmpHNSfT0UsP84/PeZxA1L+DEspV014I512Lsb/0CO8WdcNvMjAhR1AmiKWWl+MEuZyJK
 iSsS88WtXQ1RCsp4=
X-Received: by 2002:adf:9144:: with SMTP id j62mr4524197wrj.110.1602153837893; 
 Thu, 08 Oct 2020 03:43:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4WxxLHX5OsBad/kuRfG9Fkf98WxmyWG2/D97onT3r86A+QEqPA8naNLXRnGgQnz998t/Ifw==
X-Received: by 2002:adf:9144:: with SMTP id j62mr4524174wrj.110.1602153837609; 
 Thu, 08 Oct 2020 03:43:57 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:bb8c:429c:6de1:f4ec?
 ([2001:b07:6468:f312:bb8c:429c:6de1:f4ec])
 by smtp.gmail.com with ESMTPSA id q20sm6304966wmc.39.2020.10.08.03.43.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2020 03:43:57 -0700 (PDT)
Subject: Re: [PATCH] configure: add option for virtiofsd
To: "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "virtio-fs@redhat.com" <virtio-fs@redhat.com>
References: <20201007092913.1524199-1-misono.tomohiro@jp.fujitsu.com>
 <15796673-2daf-70a8-4b20-b861d4c22e62@redhat.com>
 <OSBPR01MB45820C38F613E3D38A565CCEE50B0@OSBPR01MB4582.jpnprd01.prod.outlook.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0cab3544-b9c3-ae8f-3a9d-62d026d062e6@redhat.com>
Date: Thu, 8 Oct 2020 12:43:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB45820C38F613E3D38A565CCEE50B0@OSBPR01MB4582.jpnprd01.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 01:56:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 08/10/20 11:17, misono.tomohiro@fujitsu.com wrote:
> Hi Paolo
> 
> Thanks a lot for the clear explanation. I will update the patch to follow the meson style.
> I realized virtiofsd actually needs tools (i.e. "--disable-tools --enable-virtiofsd"
> does not work with above meson.build) since virtiofsd requires libvhost_user which will
> be built ony when tools are built. So, I will keep the current dependency check (except 'have_system').

I'm thinking the behavior for --disable-tools --enable-virtiofsd would
be confusing.  Therefore, another possibility is not introducing
--enable-virtiofsd.  Instead, you can reuse --enable-vhost-user-fs:

- --enable-vhost-user-fs will fail if tools are enabled and cap-ng or
seccomp are unavailable

- --enable-vhost-user-fs --disable-tools will not look for cap-ng or
seccomp, because then the flag only controls inclusion of vhost-user-fs
in the emulators

- if "--enable-vhost-user-fs" is not specified and tools are enabled,
vhost-user-fs will only be included in the emulators if cap-ng and
seccomp are available

- if "--enable-vhost-user-fs" is not specified, tools are enabled and
cap-ng/seccomp are unavilable, vhost-user-fs will not be included in the
emulators either

- if "--enable-vhost-user-fs" is not specified but tools are not
enabled, configure will not check if cap-ng or seccomp.

In this case reusing most of your previous patch, and not moving
everything to meson, is totally okay.  I don't want you to impose more
transition work.

Paolo


