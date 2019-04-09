Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37126C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 11:39:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0677920857
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 11:39:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0677920857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39459 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDp6D-0002ZC-VU
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 07:39:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDp5S-0002I9-3I
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 07:38:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDp5K-0000XG-VO
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 07:38:40 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51871)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hDp5F-0000Tz-VJ
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 07:38:34 -0400
Received: by mail-wm1-f65.google.com with SMTP id 4so3104504wmf.1
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 04:38:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=iI+4TPuCt+X87IpY5J/Ito7fDOLnJvWGYSzCINK2BHU=;
	b=R2pzkaRA6Nv0DazCE6dEbB+2X/vUy5pO+NWmGb+D/mF1bWzOAMxAbQvp79uQRtChrL
	J1o+wEy/0vMJU+VrtHrTNbuDRiEKFuTt7Hyzr7ytmd6opcrohmSwE2eTBZXC6nc6Puyf
	G6RHkR1+FSuIx05zT/QtMHixyb8uWCsDX6rTMkULYArVSmIDHFEM4vBASggOhmYR3vYY
	i6Y3HTv0f2rKXuhIeTIgsJQHnODJAsGEFTQ2fRCI6lhadR22FxzY0gaN//k162quYaqa
	9t0+anyPUpTaw9XKzQFReNkLTh8LHMpKAKxx0+rYULCwTBKO3OzcXd63B0Mj0uRjGTyf
	QvxQ==
X-Gm-Message-State: APjAAAUpS6Mg27zwQSmwkbZH8iDjTV+WViK0LJ7LUxPBjsTwcYdKMHb3
	2aK+UQYY55vr+7bL3qEf5UqQHsKTN70=
X-Google-Smtp-Source: APXvYqwbHV/z3njPAIvn3Q25Eg8HXd8ZLg6P3CLweibDgtjnD6uhrbzX4XINe80if02OIwGhoAOeJA==
X-Received: by 2002:a1c:7dd7:: with SMTP id y206mr21149125wmc.81.1554809912175;
	Tue, 09 Apr 2019 04:38:32 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	y125sm25985402wmc.39.2019.04.09.04.38.30
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 09 Apr 2019 04:38:31 -0700 (PDT)
To: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
	=?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
References: <e5fb5172-983a-c8a0-1d86-8406fe8ff99c@redhat.com>
	<ef6ca1d8-50ac-5239-34eb-be05fad7af69@reactos.org>
	<87o95hjbtu.fsf@dusky.pond.sub.org>
	<cca2f2c2-6916-8db9-ef4c-72cd2a79c9ef@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <68660807-deb6-f08a-f714-7fa1782c70bf@redhat.com>
Date: Tue, 9 Apr 2019 13:38:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <cca2f2c2-6916-8db9-ef4c-72cd2a79c9ef@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] How to correctly use more than 2 floppy drives?
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Juan Quintela <quintela@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	QEMU Developers <qemu-devel@nongnu.org>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409113830.Wm6mbh3Vol7ECvBnmxmBDZ53IJ0c8z3kiITioWhUayQ@z>

On 4/8/19 9:30 PM, John Snow wrote:
> On 4/8/19 1:38 AM, Markus Armbruster wrote:
>> Hervé Poussineau <hpoussin@reactos.org> writes:
>>
>>> Le 05/04/2019 à 12:29, Philippe Mathieu-Daudé a écrit :
>>>> Hi,
>>>>
>>>> I am trying to understand the possible values for the MAX_FD variable
>>>> used by the floppy controller model (hw/block/fdc.c).

> Out of curiosity, why?

Cleaning Super I/O chipset I figured some code uses arrays of 2 elements
while other use MAX_FD. If we want to have a build-configurable MAX_FD
we can't simply replace "2" -> "MAX_FD" to clean the codebase, we need
to correct various places, and fix migration.
If we agree that MAX_FD is strictly 2, then we can clean the codebase
and remove the MAX_FD != 2 cases (point 3/ below).

>>>> Looking at git history:
>>>>
>>>> - 2004-01-05 7138fcfbf7dd + 8977f3c107ef (Jocelyn Mayer):
>>>>    FDC introduced with "#define MAX_FD 2"
>>>>
>>>> - 2008-04-29 78ae820cfeb0 (Hervé Poussineau):
>>>>    Supports up to 4 floppy drives if MAX_FD is set to 4
>>>>    Migration stream knows about runtime value of MAX_FD
>>>>
>>>> - 2009-09-10 d7a6c2703577 (Juan Quintela):
>>>>    FDC vmstate-ified
>>>>    Migration stream use compile time value of MAX_FD
>>>>
>>>> Since 7138fcfbf7dd MAX_FD has always been defined as 2.
>>>>
>>>> Since d7a6c2703577 MAX_FD can not be different than 2 without breaking
>>>> migration.
>>>>
>>>> If I understand correctly migration, first we should change in
>>>> vmstate_fdc the user-definable MAX_FD by a constant 2 value.
>>>>
>>>> Then to be able to use >2 floppy disks I have to modify the the
>>>> vmstate.version_id, and
>>>>
>>>> 1/ add a new field in the vmstate_fdc containing the number of drives
>>>> and add code to check >2 and adapt
>>>>
>>>> or
>>>>
>>>> 2/ change MAX_FD to 4 for all the codebase, adding some code to migrate
>>>> to older FDC with only 2 disks...
>>>>
>>>> Another option I don't like is:
>>>>
>>>> 3/ get ride of MAX_FD != 2 and clean the codebase...
>>>>
>>>> $ git grep '#if MAX_FD'
>>>> hw/block/fdc.c:744:#if MAX_FD == 4
>>>> hw/block/fdc.c:758:#if MAX_FD == 4
>>>> hw/block/fdc.c:1317:#if MAX_FD == 4
>>>> hw/block/fdc.c:1340:#if MAX_FD == 4
>>>> hw/block/fdc.c:2041:#if MAX_FD == 4
>>>> hw/block/fdc.c:2079:#if MAX_FD == 4
>>>> hw/block/fdc.c:2104:#if MAX_FD == 4
>>>>
>>>> Hervé, what board are/were you using with 4 floppy drives?
>>>
>>> That was only an attempt to support 4 drives in code, as controller was able to do it.
>>> However, no emulated board took advantage of it, so that's why it kind-of regressed.
>>>
>>> Feel free to choose the solution you prefer.
>>
>> Since no user has appeared since 2008, it feels safe enough to assume
>> that none will appear going forward.  I lean towards your "3/ get ride
>> of MAX_FD != 2 and clean the codebase..."  Explain in a comment that we
>> emulate only a 2-drive floppy controller, not the genuine IBM PC 4-drive
>> floppy controller.
>>
> 
> I think I'd rather have MAX_FD set to 2 and a cleaner codebase than a
> half-working implementation for 4.
> 
> Or, does it actually work with four? I think if Hervé wants to preserve
> this feature it should be formalized as a device property and made to
> work with migration ... or I am content to remove it.

I understand Hervé doesn't want to preserve his attempt ("no emulated
board took advantage of it"), and the work is safe in the git history if
someone want to restore it (in a way that doesn't break migration).

Since we all seems to agree, I prepared a series to remove it and will
send it soon (although there is no rush).

Thanks,

Phil.

