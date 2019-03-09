Received: from eggs.gnu.org ([209.51.188.92]:39139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h2Yoj-0000Fi-W9
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 05:02:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h2Yoj-0001R7-0E
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 05:02:57 -0500
Received: from smtp.lg.ehu.es ([158.227.0.66]:7872 helo=smtp.ehu.eus)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <unai.martinezcorral@ehu.eus>)
	id 1h2Yoi-0001Lz-M4
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 05:02:56 -0500
Received: from imsva1.lgp.ehu.es (imsva1.lgp.ehu.es [10.0.3.245])
	by postfix.smtp1.imsva1 (Postfix) with ESMTPS id 1E5F931728
	for <qemu-devel@nongnu.org>; Sat,  9 Mar 2019 11:02:48 +0100 (CET)
Received: from imsva1.lgp.ehu.es (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E3E2F110052
	for <qemu-devel@nongnu.org>; Sat,  9 Mar 2019 11:02:47 +0100 (CET)
Received: from imsva1.lgp.ehu.es (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D860B110045
	for <qemu-devel@nongnu.org>; Sat,  9 Mar 2019 11:02:47 +0100 (CET)
Received: from smtp.ehu.eus (unknown [10.0.100.73])
	by imsva1.lgp.ehu.es (Postfix) with ESMTPS
	for <qemu-devel@nongnu.org>; Sat,  9 Mar 2019 11:02:47 +0100 (CET)
Received: from mail-it1-f175.google.com (mail-it1-f175.google.com
	[209.85.166.175]) by smtp1 (Postfix) with ESMTPSA id 9B57E31753
	for <qemu-devel@nongnu.org>; Sat,  9 Mar 2019 11:02:47 +0100 (CET)
Received: by mail-it1-f175.google.com with SMTP id 188so128677itb.0
	for <qemu-devel@nongnu.org>; Sat, 09 Mar 2019 02:02:47 -0800 (PST)
MIME-Version: 1.0
References: <20190306031221.GA53@03612eec87fc>
	<20190306044620.GC75@03612eec87fc>
	<3ccb5a7c-9b64-d380-0c3b-e755c612c31f@vivier.eu>
In-Reply-To: <3ccb5a7c-9b64-d380-0c3b-e755c612c31f@vivier.eu>
Reply-To: unai.martinezcorral@ehu.eus
From: Unai Martinez Corral <unai.martinezcorral@ehu.eus>
Date: Sat, 9 Mar 2019 11:02:37 +0100
Message-ID: <CAGZZdDHmv+S-mLZUAjRGVSbFAJP7bmOWgyOwRb=8u0rZHmYA0w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 3/10] qemu-binfmt-conf.sh: add
 QEMU_CREDENTIAL and QEMU_PERSISTENT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>, qemu-devel@nongnu.org, riku.voipio@iki.fi, Eric Blake <eblake@redhat.com>

2019/3/9 10:42, Laurent Vivier:
> On 06/03/2019 05:46, Unai Martinez-Corral wrote:
> > Allow to set options '--persistent' and/or '--credential' through
> > environment variables. If not defined, defaults are used ('no').
> > Anyway, command-line arguments have priority over environment variables.
>
> Could you explain why we could need to use the env variable instead of
> the command line parameter?
>
> I don't see any use case for that.

The main use case is to provide defaults when this script is included
in a docker container. There are three actors involved:

- Developers of QEMU providing some defaults in the script.
- Developer of a docker image including the script from upstream but
changing some defaults by setting envvars inside the container.
- User of the container that might want to override the settings
either by setting the envvars or through the command line.

If the entrypoint to the docker image is any script that executes
qemu-binfmt-conf.sh at some point, the user cannot provide options
through the command line. Envvars allow to do so, without requiring
the user to customize the docker image.

Regards,

Unai
