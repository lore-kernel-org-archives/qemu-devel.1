Received: from eggs.gnu.org ([2001:4830:134:3::10]:53204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eNKDy-0003TW-JD
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 10:06:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eNKDx-0001Ue-K7
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 10:06:02 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:44033)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eNKDx-0001UD-EA
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 10:06:01 -0500
Received: by mail-ot0-x241.google.com with SMTP id d27so9376846ote.11
	for <qemu-devel@nongnu.org>; Fri, 08 Dec 2017 07:06:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171208155050.1a6db1c2@redhat.com>
References: <CAFEAcA-auykOKQbNcoQooNGk7Vb3wt7TH7AMA689xEj22_6KcQ@mail.gmail.com>
	<20171207174832.42663bef@redhat.com>
	<CAFEAcA9o-LyKZBZwSoz3SSPCY-sjo9e011UWy1=EwJ4U9rWYsg@mail.gmail.com>
	<20171207170719.GT3037@localhost.localdomain>
	<CAFEAcA9fzkedj_VLeTaK-WOTLGk1RinyadRmR5FaJ44KOAQU3w@mail.gmail.com>
	<CAFEAcA9Uh9f3UddCNiB3u6BD9Qg=sUMDmMYYn1+sryiJUMOFYg@mail.gmail.com>
	<20171208141618.11e60846@redhat.com>
	<CAFEAcA8Gc1XQVYR9+_uD7Be3WSDE5tzxVAuJNBTokb3HdJ6fHw@mail.gmail.com>
	<20171208155050.1a6db1c2@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Dec 2017 15:05:40 +0000
Message-ID: <CAFEAcA9HdYc1fteY681eMCkeBSneKHoe648qkXo_W5fQVX_3jQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] in a device or CPU instance init/realize,
 can I rely on something having the BQL or equivalent?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 8 December 2017 at 14:50, Igor Mammedov <imammedo@redhat.com> wrote:
> On Fri, 8 Dec 2017 13:19:27 +0000
> Peter Maydell <peter.maydell@linaro.org> wrote:
>
>> On 8 December 2017 at 13:16, Igor Mammedov <imammedo@redhat.com> wrote:
>> > TBH:
>> >  I do not recall why we have x86 max/host cpu types do feature
>> >  loading at realize time instead of at class init like the rest
>> >  of static cpu types.
>>
>> class init is too early, IIRC -- it's before KVM has been set up at all.
>
> that shouldn't be an issue as kvm_ppc_register_host_cpu_type() demonstrates
> (i.e. an additional class init at kvm/tcg init time),
>
> so it might be some compat issue or just legacy approach why it
> havn't been rewritten to class_init for x86 the way PPC does.
> But Eduardo probably knows better if there is anything left that
> prevents using class init there.

Hmm. In any case, feel free to review
https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg01225.html
and suggest changes if you think there's a better way of structuring
things.

thanks
-- PMM
