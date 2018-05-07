Received: from eggs.gnu.org ([2001:4830:134:3::10]:57404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fFduH-000850-SV
	for qemu-devel@nongnu.org; Mon, 07 May 2018 07:02:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fFduC-0006Cw-89
	for qemu-devel@nongnu.org; Mon, 07 May 2018 07:02:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54616 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fFduC-0006CR-2w
	for qemu-devel@nongnu.org; Mon, 07 May 2018 07:02:08 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9953F8182D0D
	for <qemu-devel@nongnu.org>; Mon,  7 May 2018 11:02:07 +0000 (UTC)
References: <1525453270-23074-1-git-send-email-thuth@redhat.com>
	<f7756c7c-338a-a719-7135-aa7a53a62c4c@redhat.com>
	<87wowgyqj8.fsf@dusky.pond.sub.org>
	<32c5b770-3bbf-e9d2-ea78-023986ba828f@redhat.com>
	<87sh73yk3z.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ff5d2f93-8629-bc78-73a5-c3af38409647@redhat.com>
Date: Mon, 7 May 2018 13:02:02 +0200
MIME-Version: 1.0
In-Reply-To: <87sh73yk3z.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org

On 07/05/2018 09:56, Markus Armbruster wrote:
>>>> I'm not that sure anymore about -no-kvm.  It can come in handy for
>>>> distros (*cough* RHEL *cough) that only ship a qemu-kvm binary with
>>>> default accelerator "-machine accel=kvm:tcg".
>>>>
>>>> Yeah, "-accel tcg" is only a few characters later, but it is a
>>>> relatively recent addition.
>>>
>>> 2012 is "relatively recent" in the alternate RHEL universe, perhaps :)
>>
>> That was the "-machine accel=tcg", but Paolo was rather talking about
>> "-accel tcg", which has been added last year. Yes, we've got three (!)
>> ways of dealing with accelerators now: "-M accel=", "-accel" and
>> "-enable-kvm + -no-kvm". We're very userfriendly, aren't we? ;-)
>
> Ugh.  Apparently, vl.c still is a playground without adult supervision.

I'm not sure I get it... "-accel" was added in order to provide
accelerator options.  If anything, "-machine accel" (added back in 2010)
is the one that makes little sense these days.

Paolo
