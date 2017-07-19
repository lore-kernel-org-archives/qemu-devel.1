Received: from eggs.gnu.org ([2001:4830:134:3::10]:59261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nmccallu@redhat.com>) id 1dXdTC-0004Uc-Tv
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 21:08:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nmccallu@redhat.com>) id 1dXdT8-0000Yv-Ls
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 21:08:06 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:35154)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nmccallu@redhat.com>) id 1dXdT8-0000Yb-HZ
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 21:08:02 -0400
Received: by mail-it0-f47.google.com with SMTP id h199so18208126ith.0
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 18:08:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5e542ce6-4192-4590-163e-de54002d74dd@redhat.com>
References: <CAOASepMWrxm0OxvuzeujfVK8JN-UzKCXtaz2vJRgGno=8CSMqQ@mail.gmail.com>
	<5e542ce6-4192-4590-163e-de54002d74dd@redhat.com>
From: Nathaniel McCallum <npmccallum@redhat.com>
Date: Tue, 18 Jul 2017 21:08:01 -0400
Message-ID: <CAOASepNxd4VT5usLnXLB9Kx=_K3h-N5nqmYArLWaRaQY5Cud3Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] Update references of "struct ucontext" to
 "ucontext_t"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, raj.khem@gmail.com

Yes, it is a dup. Sorry for the noise.

On Tue, Jul 18, 2017 at 9:03 PM, Eric Blake <eblake@redhat.com> wrote:
> On 07/18/2017 07:58 PM, Nathaniel McCallum wrote:
>> Glibc used to have:
>>
>>    typedef struct ucontext { ... } ucontext_t;
>>
>> Glibc now has:
>>
>>    typedef struct ucontext_t { ... } ucontext_t;
>>
>> However, Qemu used "struct ucontext" in declarations. This is a
>> private name and compatiblity cannot be guaranteed. This patch
>> updates Qemu to only use the standardized type name.
>>
>> Signed-off-by: Nathaniel McCallum <npmccallum@redhat.com>
>> ---
>
> Looks like this duplicates:
> https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg06508.html
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
>
