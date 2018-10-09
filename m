Received: from eggs.gnu.org ([2001:4830:134:3::10]:50343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1g9rqu-0007Zo-S2
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:15:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1g9rqp-00050F-Br
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:15:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:5776)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1g9rqp-0004yo-5t
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:15:03 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1538748792-19444-1-git-send-email-thuth@redhat.com>
	<CAFEAcA8SJ8QBX9fHPm+DvtdpJYq_vwx0CGsH8Uyp_AV-KMqqDA@mail.gmail.com>
	<875zybzdzm.fsf@dusky.pond.sub.org>
Date: Tue, 09 Oct 2018 15:14:59 +0200
In-Reply-To: <875zybzdzm.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Tue, 09 Oct 2018 11:05:49 +0200")
Message-ID: <87zhvntg6k.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] accel: Improve selection of the default
 accelerator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Markus Armbruster <armbru@redhat.com> writes:

> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> On 5 October 2018 at 15:13, Thomas Huth <thuth@redhat.com> wrote:
>>> When compiling with "--disable-tcg", we currently still use "tcg"
>>> as default accelerator. "kvm" should be used in this case instead.
>>
>> This part is non-controversial and makes good sense.
>
> Agreed.
>
>>> Also, some downstream distros provide QEMU binaries which have "kvm"
>>> in their names (e.g. "qemu-kvm" on RHEL or "kvm" on Ubuntu) that use
>>> KVM by default - and some users might want to do something similar
>>> with upstream binaries, too. Accomodate them by using "kvm:tcg" as
>>> default when we detect such a binary name.
>>
>> This part is much riskier and less clearly a good plan --
>> do we really want our behaviour to vary based on the name
>> of the executable? Distros who want that sort of qemu-kvm
>> wrapper generally are providing it already (the Ubuntu one
>> is a 2-line shell script).
>
> I hate it when argv[0] affects behavior[*].  I hate shell wrappers less.
>
> If a system provides just one qemu executable, and its default
> accelerator should be something other than tcg:kvm, then there's a use

Correction: "other than tcg".  See configure_accelerator().

Remind me, why is "tcg" a good default?

> for making it compile-time configurable.  Reading the default from /etc/
> would also work.  Not sure such a system exists.
>
>
>
> [*] Go document the behavior with proper precision, and you might come
> to share the feeling.
