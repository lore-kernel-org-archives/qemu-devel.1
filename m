Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AAAC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 11:56:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB33E21924
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 11:56:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB33E21924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAv3O-0003Ut-Mf
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 07:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34048)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iAv1K-0001YW-Fo
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 07:54:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iAv1J-0000T4-1w
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 07:54:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:4081)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iAv1I-0000SN-RH
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 07:54:45 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D355C369AC
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 11:54:43 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id f10so1466596wmh.8
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 04:54:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oZSJkfEIC7y9ibClBt5n6B80dJNhG+DmuFapUmQSFY8=;
 b=jg0FObEinwX3SBw2Q95vnQI41oAG5ugZ3vvZqbvAxax3LGylJymvLFSnIOaVmN70zi
 L3lAAcPrzxrnEqhQ5+cNONxU/MVfEbm41bBnYVj/Vv/JcNgqoCB7HtOW/EBDV21H6Iz/
 VGvJLTTAzI+gg9otA+ptcIHX8Zqg92i4bFwKGqSIXBDmfHQmXe1MJSuSAfOA+LQtIQM6
 rP7LxWIRd3Ljz1i/LIZEVnvtM6JMHvJx2JFOhBvtXF+D/y5pjUWWA37FuuGaawNMYkCA
 cpAFexaDAKmANVJNiSoXhUgUzt+zCjuOSZj63fNYoV/jo9CuQIr22lsYpHCBnR0Lswp9
 Qb8w==
X-Gm-Message-State: APjAAAWBeU7iOqT2cTYE2/thNTb0DAfyUvOb2x/In9vkKBNqY3iYrKp2
 U0VeWNabm4SGPz3NaJmVmEAqmKk9p6b2D5ielEyhhiGPDEujvtldu9qHyvHcrSZzhFlEo+cfNwr
 YY12vBds8FyArwGI=
X-Received: by 2002:adf:fd8c:: with SMTP id d12mr7331787wrr.142.1568894082481; 
 Thu, 19 Sep 2019 04:54:42 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw+BEIFQTB4rKVw5jZiSspCL39KpO2qcB15nFR/dwbfIVh0pXVTyIL6C9H1H5vTCNSAUkM7Zw==
X-Received: by 2002:adf:fd8c:: with SMTP id d12mr7331758wrr.142.1568894082132; 
 Thu, 19 Sep 2019 04:54:42 -0700 (PDT)
Received: from [192.168.1.115] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id 17sm9083687wrl.15.2019.09.19.04.54.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Sep 2019 04:54:41 -0700 (PDT)
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Stefan Weil <sw@weilnetz.de>
References: <20190919105932.19412-1-philmd@redhat.com>
 <04454c37-ad8b-b69b-3f40-bb78f0c20ef2@weilnetz.de>
 <20190919114152.GK20217@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <982785f8-6864-46cb-dca2-0a9877c2d92e@redhat.com>
Date: Thu, 19 Sep 2019 13:54:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190919114152.GK20217@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/2] testing: Build WHPX enabled binaries
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
Cc: Fam Zheng <fam@euphon.net>, Lucian Petrut <lpetrut@cloudbasesolutions.com>,
 qemu-devel@nongnu.org, Justin Terry <juterry@microsoft.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Ilias Maratos <i.maratos@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/19/19 1:41 PM, Daniel P. Berrang=C3=A9 wrote:
> On Thu, Sep 19, 2019 at 01:18:57PM +0200, Stefan Weil wrote:
>> Am 19.09.2019 um 12:59 schrieb Philippe Mathieu-Daud=C3=A9:
>>> Add a job to cross-build QEMU with WHPX enabled.
>>>
>>> Use the Win10SDK headers from the Android Project, as commented
>>> in https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg03842.htm=
l
>>>
>>> Based-on: <20190918121101.30690-1-philmd@redhat.com>
>>> https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg03844.html
>>>
>>> Philippe Mathieu-Daud=C3=A9 (2):
>>>   tests/docker: Add fedora-win10sdk-cross image
>>>   .shippable.yml: Build WHPX enabled binaries
>>>
>>>  .shippable.yml                                |  2 ++
>>>  tests/docker/Makefile.include                 |  1 +
>>>  .../dockerfiles/fedora-win10sdk-cross.docker  | 21 +++++++++++++++++=
++
>>>  3 files changed, 24 insertions(+)
>>>  create mode 100644 tests/docker/dockerfiles/fedora-win10sdk-cross.do=
cker
>>>
>>
>> Please note that the required header files are part of the Win10SDK
>> which is not published under a free license, so I am afraid that they
>> cannot be used with QEMU code to produce free binaries.
>=20
> Can you elaborate on why you think that is the case ?
>=20
> Looking at the 3 header files used, all they contain are struct
> definitions and integer constants, fortunately no functional
> code in macros or inline functions. As such, it is questionable
> whether the headers alone can be considered copyrightable material.
> Any compatible implementation that follows the WHPX API/ABI will by
> neccessity be the same, modulo code style.
>=20
> Further, from a GPL POV, these headers should fall under the system
> libraries exception, as WHPX is core low level operating system
> functionality.
>=20
> There's a valid legal question as to how to we got access to the
> files in the first place. Assuming they are freely distributable
> though, given their hosting on Google Android downloads.
>=20
> So the fact that the headers are not under an open source / free
> license doesn't look like it should impact the ability to distribute
> the resulting QEMU binaries.

Are we distributing the resulting binaries?
I don't think so, we only build until linking in a scratch container and
discard its content, we don't have access to the container storage via
Shippable (also Travis). We only use the exit code and the console
output from the build.

We are not distributing those headers neither, as we currently do not
distribute the docker images.

Regards,

Phil.

