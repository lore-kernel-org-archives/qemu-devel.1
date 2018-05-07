Received: from eggs.gnu.org ([2001:4830:134:3::10]:40430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fFecR-0002d6-GS
	for qemu-devel@nongnu.org; Mon, 07 May 2018 07:47:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fFecO-0006z5-EK
	for qemu-devel@nongnu.org; Mon, 07 May 2018 07:47:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46542 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fFecO-0006yk-AF
	for qemu-devel@nongnu.org; Mon, 07 May 2018 07:47:48 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 563FC4078BB9
	for <qemu-devel@nongnu.org>; Mon,  7 May 2018 11:47:44 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1525453270-23074-1-git-send-email-thuth@redhat.com>
	<f7756c7c-338a-a719-7135-aa7a53a62c4c@redhat.com>
	<87wowgyqj8.fsf@dusky.pond.sub.org>
	<9bbc2a49-4819-35fe-d164-ef88aa2494c2@redhat.com>
Date: Mon, 07 May 2018 13:47:39 +0200
In-Reply-To: <9bbc2a49-4819-35fe-d164-ef88aa2494c2@redhat.com> (Paolo
	Bonzini's message of "Mon, 7 May 2018 13:00:15 +0200")
Message-ID: <871senwuuc.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 0/5] Removal of deprecated -no-kvm*
 options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 07/05/2018 07:37, Markus Armbruster wrote:
>>> I'm not that sure anymore about -no-kvm.  It can come in handy for
>>> distros (*cough* RHEL *cough) that only ship a qemu-kvm binary with
>>> default accelerator "-machine accel=kvm:tcg".
>>>
>>> Yeah, "-accel tcg" is only a few characters later, but it is a
>>> relatively recent addition.
>>
>> 2012 is "relatively recent" in the alternate RHEL universe, perhaps :)
>
> Well, that's for "-machine accel=tcg" which is quite a mouthful.

"-M accel=tcg" is a whopping *two* characters more than "-accel tcg".

> "-accel tcg" was added in 2.9, about a year ago (commit 8d4e9146b3,
> "tcg: add options for enabling MTTCG", 2017-02-24).

Yes, I confused the two.
