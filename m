Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C22C33CB2
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 14:28:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83472207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 14:28:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83472207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwRr9-0005H2-SF
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 09:28:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50071)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iwRqa-0004pl-LJ
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 09:28:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iwRqZ-0005kK-6k
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 09:28:08 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:36829)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iwRqY-0005jf-Tq
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 09:28:07 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MelWf-1jX9ds3mab-00aoRI; Tue, 28 Jan 2020 15:28:02 +0100
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <CAL1e-=j5WJkV=X+KkfBuS3pjf6z3aJrtu4xpYeVbjEUYiWxxTQ@mail.gmail.com>
 <20200127093004.GA18565@stefanha-x1.localdomain>
 <CAL1e-=h+g4FWVDVe6a4T_X_nEA-catKd+7LiKXx++qS+G7mqOQ@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [GSoC/Outreachy QEMU proposal] Extend support for ioctls in QEMU
 linux-user mode
Message-ID: <74b19db2-8ed2-c0c4-2870-b60dd49789cd@vivier.eu>
Date: Tue, 28 Jan 2020 15:28:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=h+g4FWVDVe6a4T_X_nEA-catKd+7LiKXx++qS+G7mqOQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:S5qTP4wx21f5vTo3i9ds+4jnuNc9ciczjmlneFJq+PLDE5Vc/qB
 YqdG2iKMzlSrLOLkhpP0dBNbmUs/yFY8t/DuZZpdSq01dqJlUJfXuBCPwFaz0ZL+fnQn4ng
 CSmEot5ydRAfEJW7LocWYGltdhZCl1NQlfdlFQUhWV7nfhE8KUI4j06z0arJaAEkYgP3prd
 6co0rmqqXEf088msrIkfg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hQ5jTdjc8WQ=:6zpg3lAvV9w5nWoZiBdgmi
 FrxRl2z27BCFDwMFSx3y5Pd/gtY3i8/Ti5fEZ+T9NGuudS2LxCkr9VuO52UuVstwoJ0+cL3pa
 Tg3zHNjeglaI5zvb9a5ZfuRXxvhTW3Wt0fvldv6Iq7idy0XGBaREZ7ix30sScoDybwv3VTsg0
 ySHFrAblw3WklXzRFaa1rHE1gTfvN6z2+olO6n7uAMKiAvyGVVNswKKW51xuBedJtheXIj013
 UPZ86W+GPDOXcLCm+SN0VsiDvddyNqFgpL2PBCs+nub4BHCxmgKDSxMhkDiufouDLboTL+i8A
 jylQMS/HLdoe3pzjh+sBCmhd5fM/lPCDEjwy6QZ4lo9nPYxwyUG6XMilj2R9Z9/NYt5PO7Ob+
 MZkU3K9FSvRDwmEQUewt8kPiO08yJ8fqVJhJMMRMcGAuN+vt90QzfSy3RVJMs0hXH0IXMABfH
 Qw30Ar89Tg5Dm0SSXgTWfsmJUZs8bQZs5U+Kwnf9C8ToRStby483k9o50ARB5RACp0YTDRVo3
 biFh/ZVLe5Kv/uSAhszLpem4fiopW0ErHwREfulXzmNl0tp5sojgiapW8PvpRawfgFmcrlQ1e
 L1RpOeFkB3pVLQ2XqsmPPUJqvD9c/43MVvO/aQKNGl7nSbMw1nUAoI3sfG2D1HmgSKmH+9mRc
 eCqEdHpm2qsmCMQ8PrjSbPMYDk0zGVsa87yKPnyBaN93yrEMdBxfuo4SEFDphY+p5/d0N5//z
 4hJnhPQQvN+VjEZgG+9MGWkF1p/9K3QWmuLSCRnuha0kKNIN9zhFZ4uGXDQMk3ui2JLeF41jH
 ENTK1Q5K5AcgKAyWBen6YG41WcHwehIgXZO0oCqZjo/Ih+jQR8BaEk5iYdSu5mluOjL+0xL
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.130
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 27/01/2020 à 17:30, Aleksandar Markovic a écrit :
> 
> 
> On Mon, Jan 27, 2020 at 10:30 AM Stefan Hajnoczi <stefanha@redhat.com
> <mailto:stefanha@redhat.com>> wrote:
>>
>> On Thu, Jan 23, 2020 at 02:34:01PM +0100, Aleksandar Markovic wrote:
>> > *Extend support for ioctls in QEMU linux-user mode*
>> >
>> >
>> >
>> > *PLANNED ACTIVITIES*
>> >
>> > BACKGROUND
>> >
>> > There is currently 2500+ ioctls defined in Linux kernel. QEMU linux-user
>> > currently supports only several hundred. There is a constant need for
>> > expanding ioctl support in QEMU. Users use Linux-user mode in variety of
>> > setups (for example, building and testing tools and applications under
>> > chroot environment), and, on a regular basis, efforts by multiple people
>> > are made to fill in missing support. However, these efforts have been
>> > usually done on a piece-by-piece basis, i a limited way covering a
>>
>> s/ i / in /
>>
>> > partucular need. This project will take more proactive stance, and
> try to
>>
>> s/partucular/particular/
>>
>> > improve QEMU before users start complaining.
>> >
>> > PART I:
>> >
>> >    a) Add strace support for outputing ioctl IDs (the second argument of
>> > ioctl()) as strings rather than numbers - for all platform independant
>> > ioctls.
>> >    b) Add strace support for printing the third argument of ioctl()
> (be it
>> > int, string, structure or array) - limited to selected ioctls that are
>> > frequently used.
>> >
>> > PART II:
>> >
>> >    a) Amend support for existing groups of ioctls that are not completed
>> > 100% (let's say, filesystem ioctls)
>> >    b) Add support for a selected group of ioctls that are not currently
>> > supported (for example, dm ioctls, Bluetooth ioctls, or Radeon DRM
> ioctls)
>> >
>> > PART III:
>> >
>> >   a) Develop unit tests for selected ioctls that are already
> supported in
>> > QEMU.
>> >
>> >
>> > *DELIVERABLES*
>> >
>> > The deliverables are in the form of source code for each part,
> intended to
>> > be upstreamed, and time needed for upstreaming (addressing reviews,
> etc.)
>> > process is included int this project.
>> >
>> > The delivery of results can and should be distributed over larger
> period of
>> > time 2-3 months.
>>
>> Good project idea.  Please choose concrete ioctls.  Applicants may not
>> have the necessary experience to choose a set of ioctls that are useful.
>>
> 
> PART I should not be that difficult. PART II is, however, a minefield.
> An implementation of support of a ioctl range from 15 minutes to two
> months. The least we wont to happen is that the student is stuck with a
> problem for months. Therefore I suggest first some "low hanging fruit"
> for a student to get self-confidence and experience. One such group is
> DM ioctl group ( link
> <https://github.com/torvalds/linux/blob/master/include/uapi/linux/dm-ioctl.h#L251>
> ) (Laurent may confirm, or "unconfirm" that). The next shoudl be

Well, ioctl are generally implemented on demand when we see there is one
missing. DM can be interresting, but do we have an easy way to test them?

> something a little harder, but useful in terms of end user. PART III
> should be developed on the fly, but we need to provide a
> guideline/framework prior to starting working with a student, IMHO..
> 
>> I wonder if it's possible to use something like the Debian popularity
>> contest (https://popcon.debian.org/) and then scan the source of the
>> most popular N packages for ioctl() calls.
> 
> Great! I'll try. A very interesting site and method.
> 

The other point to implement ioctl that we know are used by a given
package is we can run this package to see if it works or not before and
after the implementation of the missing ioctl.

We can also rely on some test suites provided by the packages.

We can also detect missing ioctl by looking at "Unsupported ioctl: cmd="
error message while we run chroot.

It could be interesting to run a gnome-session from inside a chroot with
qemu-linux-user to trigger more multimedia related ioctl.

Thanks,
Laurent


