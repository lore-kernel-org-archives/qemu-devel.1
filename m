Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960DFC4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 10:31:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57AC520652
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 10:31:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57AC520652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39579 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCM7f-0005Cv-P6
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 06:30:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCM6Y-0004ls-A2
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 06:29:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCM6V-0001OP-Mw
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 06:29:50 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53873)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hCM6R-0001DN-DT
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 06:29:45 -0400
Received: by mail-wm1-f67.google.com with SMTP id q16so6090465wmj.3
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 03:29:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:to:from:openpgp:cc:subject:message-id:date
	:user-agent:mime-version:content-language:content-transfer-encoding;
	bh=V2eF8jGDRGMrJiAo2fhIQlKuhPF7t3UOd9/7O+4KDng=;
	b=W413yteczYLnZirUKJLdBZ6QWRPLCRm3KCpD3hkHXlg4e9sDj8dOH7S0PDemULBa/i
	1GlNEEjO5UugqTb2WcFL5KOD2E6puqFKcq87vCjEgQK02SKeLGf+Dwt+JP1bo6FzSBEg
	mLjFV7sZivxQlISCrk0/JM5omLyjdxmUr/igY9uzNoYEf9EsRxfYJ1igWTK+kDoEUZh1
	JhUrVD9EKCLmc5PB4hwR2xVwQNf+Z6DtlkFEgNdceMGWiMD809IhgrE9Q4G/uKFpIEt7
	SAPbgX9XZHYnbJJknADsNZo+lHdXWTNfa6Sjn+gUWNnJOQn7ZsOws8GXZ6CDtlizftqP
	Gbdg==
X-Gm-Message-State: APjAAAWhJDMfpMbNR9T4igmJ1aKldN6XZeaVYTxsYknFpxldYOXZGJbV
	Wsfo4BZN6QGHe3wCQBj3HrQNENX+8oA=
X-Google-Smtp-Source: APXvYqzUxeM3C3zW/rCB7mv5kIwGWDmLv9TkozXAB/Lgax7o+4EOFT8ktQJ798NpJVinqdkqVl0qRw==
X-Received: by 2002:a1c:a64d:: with SMTP id p74mr7762029wme.89.1554460181668; 
	Fri, 05 Apr 2019 03:29:41 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	o17sm23260348wrw.73.2019.04.05.03.29.40
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 05 Apr 2019 03:29:41 -0700 (PDT)
To: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
	Juan Quintela <quintela@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Thomas Huth <thuth@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <e5fb5172-983a-c8a0-1d86-8406fe8ff99c@redhat.com>
Date: Fri, 5 Apr 2019 12:29:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.67
Subject: [Qemu-devel] How to correctly use more than 2 floppy drives?
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405102939.7AF94ljkTB9o-PQT2M15xiYNu8iHF_IGlCinOMIjDow@z>

Hi,

I am trying to understand the possible values for the MAX_FD variable
used by the floppy controller model (hw/block/fdc.c).

Looking at git history:

- 2004-01-05 7138fcfbf7dd + 8977f3c107ef (Jocelyn Mayer):
  FDC introduced with "#define MAX_FD 2"

- 2008-04-29 78ae820cfeb0 (Hervé Poussineau):
  Supports up to 4 floppy drives if MAX_FD is set to 4
  Migration stream knows about runtime value of MAX_FD

- 2009-09-10 d7a6c2703577 (Juan Quintela):
  FDC vmstate-ified
  Migration stream use compile time value of MAX_FD

Since 7138fcfbf7dd MAX_FD has always been defined as 2.

Since d7a6c2703577 MAX_FD can not be different than 2 without breaking
migration.

If I understand correctly migration, first we should change in
vmstate_fdc the user-definable MAX_FD by a constant 2 value.

Then to be able to use >2 floppy disks I have to modify the the
vmstate.version_id, and

1/ add a new field in the vmstate_fdc containing the number of drives
and add code to check >2 and adapt

or

2/ change MAX_FD to 4 for all the codebase, adding some code to migrate
to older FDC with only 2 disks...

Another option I don't like is:

3/ get ride of MAX_FD != 2 and clean the codebase...

$ git grep '#if MAX_FD'
hw/block/fdc.c:744:#if MAX_FD == 4
hw/block/fdc.c:758:#if MAX_FD == 4
hw/block/fdc.c:1317:#if MAX_FD == 4
hw/block/fdc.c:1340:#if MAX_FD == 4
hw/block/fdc.c:2041:#if MAX_FD == 4
hw/block/fdc.c:2079:#if MAX_FD == 4
hw/block/fdc.c:2104:#if MAX_FD == 4

Hervé, what board are/were you using with 4 floppy drives?

BTW this link is somehow interesting :)
https://www.seasip.info/VintagePC/floppies.html

Thanks,

Phil.

