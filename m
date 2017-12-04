Received: from eggs.gnu.org ([2001:4830:134:3::10]:41437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eLuOb-0006g4-MA
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 12:19:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eLuOa-0001Xd-V1
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 12:19:09 -0500
Received: from mail-ot0-x230.google.com ([2607:f8b0:4003:c0f::230]:33208)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eLuOa-0001XV-PE
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 12:19:08 -0500
Received: by mail-ot0-x230.google.com with SMTP id h9so15383548oti.0
	for <qemu-devel@nongnu.org>; Mon, 04 Dec 2017 09:19:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_yWQqGAzDuaPZo9vgwVywq9QazToVy7CYncVvSfhxDKw@mail.gmail.com>
References: <1512148088-28733-1-git-send-email-mst@redhat.com>
	<CAFEAcA-B7nMNTj6+HOSu=qUzaK3+Me83v_OG04=a2W4MU-KziA@mail.gmail.com>
	<20171203064856-mutt-send-email-mst@kernel.org>
	<CAFEAcA_yWQqGAzDuaPZo9vgwVywq9QazToVy7CYncVvSfhxDKw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Dec 2017 17:18:47 +0000
Message-ID: <CAFEAcA8Q5DFEEY5kH=dKESPpXuP1xHaSvKJ2SefJLLd1T3VBPA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/7] pc, pci, virtio: fixes for rc3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 4 December 2017 at 10:16, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 3 December 2017 at 04:56, Michael S. Tsirkin <mst@redhat.com> wrote:
>> On Fri, Dec 01, 2017 at 06:05:25PM +0000, Peter Maydell wrote:
>>> Are any of these so important that we would absolutely refuse
>>> to release without the fixes (ie they justify rolling an rc4
>>> that we would otherwise not have needed) ?
>
>> The msi one is less important it just happened to be queued a while ago
>> and I didn't want to rebase all testing. Others are crashers but they
>> don't affect everyone. So I wouldn't be sure, but there's also a
>> security fix in there, so yes, I suspect we are better off with rc4, and
>> if we do I think including others is justified (except maybe the msi
>> one, if you feel strongly I'll rebase and drop it).
>
> The bar has to be set quite high here, because if it turns out
> that there are problems with a bug fix then we are out of time
> to rework or revert it. And the more fixes we throw in at the
> last minute, even if they're individually simple, the more
> likely that one of them turns out to have unexpected consequences.
>
> So: were any of these bugs present in the 2.10 release? If so,
> that strongly argues for not trying to fix them at this point.
>
> With all of these patches plus David Gibson's, that would be
> 10 new patches in rc4. That is definitely more than would be
> ideal.

After some discussion on IRC we decided that these should go in.

Thanks for the further information; pull applied to master.

-- PMM
