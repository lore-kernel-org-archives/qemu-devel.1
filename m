Received: from eggs.gnu.org ([2001:4830:134:3::10]:48298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXmcy-0005al-DK
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 07:31:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXmcu-0004Dp-94
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 07:31:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58516)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gXmcu-0004DN-36
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 07:31:32 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181213175552.14857-1-wainersm@redhat.com>
	<CAFEAcA86SDLGyqL3rG-fEDFsEj8-nz-Uqn5Mb9EeLqiFPeKZfA@mail.gmail.com>
	<cccf3c43-0e51-bbbc-3676-17286b11ec99@redhat.com>
	<CAFEAcA9CpR=JGt74=xaUddYhf5SCOoeHH_v+O1L+rrTygZ7quQ@mail.gmail.com>
	<860b98f8-02d0-4c96-ccf2-d582ca295b95@redhat.com>
	<871s6kfwoo.fsf@dusky.pond.sub.org>
	<CAFEAcA_KP532BBsESjO1NuKSeefSKH7RdpCdSDLfgMCtc6D5nw@mail.gmail.com>
Date: Fri, 14 Dec 2018 13:31:18 +0100
In-Reply-To: <CAFEAcA_KP532BBsESjO1NuKSeefSKH7RdpCdSDLfgMCtc6D5nw@mail.gmail.com>
	(Peter Maydell's message of "Fri, 14 Dec 2018 11:20:10 +0000")
Message-ID: <87tvjgp9wp.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 0/1] checkpatch: checker for comment block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 14 Dec 2018 at 06:29, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>
>> > On 13/12/18 19:21, Peter Maydell wrote:
>> >> On Thu, 13 Dec 2018 at 18:07, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> >>> On 13/12/18 19:01, Peter Maydell wrote:
>> >>>> I sent a patch to do this a little while back:
>> >>>>  https://patchwork.kernel.org/patch/10561557/
>
>> >>>> Personally I think we should just commit my patch, and then
>> >>>> we can stop having people manually pointing out where
>> >>>> submitters' patches don't match CODING_STYLE.
>>
>> Concur.  It has my R-by, modulo a commit message tweak.
>
> I have to admit I never really understood what tweak
> you wanted making to the commit message. I'm happy
> to make it clearer: do you want to suggest a rewording?

The commit message claims "(The only changes needed are that Linux's
checkpatch.pl WARN() function takes an extra argument that ours does
not.)"  This isn't the case.  You also dropped the kernel's "Networking
with an initial /*" special case.

The simplest way to fix an incorrect claim is to delete it :)

If you want to explain what you changed, you could say something like
"(The only changes needed are that Linux's checkpatch.pl WARN() function
takes an extra argument that ours does not, and the kernel has a special
case for networking code we don't want.)"
