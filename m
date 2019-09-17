Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D23C4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 11:03:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6724421670
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 11:03:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6724421670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iABGz-00038T-D6
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 07:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51614)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iABDx-0001Z0-Nx
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 07:00:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iABDw-0004Sj-31
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 07:00:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60290)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iABDv-0004RU-NR
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 07:00:43 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 23EA23B558
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 11:00:42 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id b6so1186230wrx.0
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 04:00:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wSzNTKefRTNv6dxVX888ROxgz8neOc/3d2LLBCrP1Zo=;
 b=P3RNO/p1G4vZBHls7+L8jaz9IkCwB/1ZL8Q1XzM800dif9JUr6dGGpJCzWY73SWPRZ
 047/8ZAhSmDkIyGSDgX9j618g3uwVt/fpayZbgf1NRgHbpZ9xhK9ICmV43mzRdWFGCdQ
 9BJlpE6hC8GLR5kW6ETERmrxIEEZthtpkoeUHaWaaiVJP4FAx0izD7vtu48VO1Oz0v2d
 1aFYnniaoufaMzaG1Y6HdNrCowMf+wfVgnVWDNL5JvkV2eR+4+d2PFgrxxL4AViZXyaX
 aivViyoLvLmiAsTm2u+Q2Q7JvajqW0kY0X98LIjHyqoapanTGLChGjNd/oyqEly+rlr0
 YbFw==
X-Gm-Message-State: APjAAAUcaiMfC35edcU24UTr9WAEG2UZCuc9paSMCQeHKxCfb3xr639b
 XkFW4gxfi0OWjcfxzATuCmbdwLjH14zd6OG1GSI+vxX4fYrFXsYSSHu96nFm1NcY8Nwb9qjLCmu
 zuMG4qPSvmpdiPSQ=
X-Received: by 2002:a1c:7914:: with SMTP id l20mr3023777wme.155.1568718040920; 
 Tue, 17 Sep 2019 04:00:40 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxMls8xM/Rwo+j6jZMA4hI6gpE0ct/tqNdzBRB015ocXFc5YOG2Qc8GG1jk42vDrZiNlrUQEA==
X-Received: by 2002:a1c:7914:: with SMTP id l20mr3023730wme.155.1568718040640; 
 Tue, 17 Sep 2019 04:00:40 -0700 (PDT)
Received: from [192.168.1.40] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id h7sm2074263wrt.17.2019.09.17.04.00.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Sep 2019 04:00:39 -0700 (PDT)
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
References: <156871562997.196432.17776290406203122029.stgit@bahia.lan>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <551745c2-2579-9ce5-4aa4-536c37a1ce45@redhat.com>
Date: Tue, 17 Sep 2019 13:00:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <156871562997.196432.17776290406203122029.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 00/17] Fix usage of error_append_hint()
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, David Hildenbrand <david@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Eric Farman <farman@linux.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Yuval Shaia <yuval.shaia@oracle.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For some reason your email client escaped incorrectly Daniel's email:

  "Daniel P. Berrang=C3=A9\" <berrange@redhat.com>

Which makes my email client very unhappy (Thunderbird):

There are non-ASCII characters in the local part of the recipient
address "Daniel P. Berrang=C3=A9 <berrange@redhat.com>,
qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
qemu-s390x@nongnu.org"@d06av23.portsmouth.uk.ibm.com. This is not yet
supported. Please change this address and try again.

Neither is MTA:

An error occurred while sending mail. The mail server responded:
5.1.2 The recipient address <qemu-s390x@nongnu.org@d06av22.portsmouth.uk.=
ibm
5.1.2 .com> is not a valid RFC-5321 address. r28sm2465872wrr.94 - gsmtp.
 Please check the message recipient
""qemu-s390x@nongnu.org"@d06av22.portsmouth.uk.ibm.com" and try again.

