Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F18C4724C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 12:23:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F7CA2068E
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 12:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CPevrVtM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F7CA2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUUhu-0006xO-1J
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 08:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57210)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jUUgu-0006OR-T1
 for qemu-devel@nongnu.org; Fri, 01 May 2020 08:22:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jUUgu-0003yi-Ec
 for qemu-devel@nongnu.org; Fri, 01 May 2020 08:22:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38103
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jUUgu-0003yP-1u
 for qemu-devel@nongnu.org; Fri, 01 May 2020 08:22:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588335771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OA/2ZyzKe+uUuMq/dbGTl5TaFttq4GV/M3Bi9pa436E=;
 b=CPevrVtMpQAi+Jg/vSpV2RV5E+1u93Ef72m/ZuQATsYs0RGW9jLQlzwF47AiDmNVBLtzsZ
 Zv1FBmyreTPvzFd2L3ZJIVi2lNtd0pcZk4qMxHSTbxeDunNGm7XD6omHBXuNVFV2IXkek5
 yT3Fuf7PArc+t+giJKCpSsBpNN3oW4s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-oua2DchLNr2g7njhKP8Ghw-1; Fri, 01 May 2020 08:22:49 -0400
X-MC-Unique: oua2DchLNr2g7njhKP8Ghw-1
Received: by mail-wr1-f69.google.com with SMTP id p2so5575824wrx.12
 for <qemu-devel@nongnu.org>; Fri, 01 May 2020 05:22:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wN3nchWcCoQRhX8LfODWfPEELW4nQCpQf/CvVEOG2VM=;
 b=b+7Md7bdEV9CNoj6xnMuW4Uq6WVUWuSLfsS2EGdf3ne4d2uc7rKA3DKJ/LxPt9ZSFu
 XHRwNDc9scQjtSc5I3Trgkk9bisRi137lwp9U59kLmEK+vEwYdDCnJqjBmawqAtOE03D
 HpJHCUGyIbTnzVV8ltD5E+Sve6+U9qQA2K0w90QGX5xxOYq+2yL7Gk7tdjjDRYwdBeRS
 jxisJfb0g0mnf2ITiil/dHP3fo0dQSnrQcOx7CGFXYXTrNxK08KiYP21MeoTzaDCJ46a
 VNZIo6P5JBntoALSmmpn4N4UVTBoBJxdRBR0Wf0QJCvp8SpGJmjIM8bErO4kJslPeO+a
 sMVQ==
X-Gm-Message-State: AGi0PubwAcQWvzN8wEeveKMGaqQTGqbn4y5Bj9eZH+BzQDMzAkFOcgnv
 KpfyOhfyN8ZiCeNgrkHeKe3xqPYjbnaqUagk6eRN7wr/2Ke2cZ3bGCTfJozirP3JRgVex8F4Of8
 M2ZWuFBt/Bg8I4XY=
X-Received: by 2002:a05:6000:146:: with SMTP id r6mr753296wrx.9.1588335768215; 
 Fri, 01 May 2020 05:22:48 -0700 (PDT)
X-Google-Smtp-Source: APiQypL45d4GvVmHAf/nJC2fvPpqBrtLobsMFFOMLzDxZ23SaNB0p9os3YxTCPMv7qVISzjxaiTdaQ==
X-Received: by 2002:a05:6000:146:: with SMTP id r6mr753283wrx.9.1588335768046; 
 Fri, 01 May 2020 05:22:48 -0700 (PDT)
Received: from [192.168.1.39] (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id d7sm3983284wrn.78.2020.05.01.05.22.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 May 2020 05:22:47 -0700 (PDT)
Subject: Re: [PATCH v1 0/4] testing/next updates
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200501111505.4225-1-alex.bennee@linaro.org>
 <20200501112321.GK2203114@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2eedbb60-79e9-083f-f3c0-d458ea74ef42@redhat.com>
Date: Fri, 1 May 2020 14:22:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200501112321.GK2203114@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/01 08:22:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/1/20 1:23 PM, Daniel P. Berrang=C3=A9 wrote:
> On Fri, May 01, 2020 at 12:15:01PM +0100, Alex Benn=C3=A9e wrote:
>> Hi,
>>
>> The following updates bring us to green across the board again. MacOSX
>> has been getting continually flakey on Travis but we still have
>> coverage on Cirrus. Please review.
>=20
> Does anyone ever look at the cirrus jobs ?  They don't notify us
> like the travis jobs so, so I feel like they're basically invisible.

Similar to Shippable and GitLab.


