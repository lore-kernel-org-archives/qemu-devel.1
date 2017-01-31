Received: from eggs.gnu.org ([2001:4830:134:3::10]:47869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1cYgXK-00048v-GE
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 17:04:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1cYgXJ-00052F-I5
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 17:04:26 -0500
Received: from mail-vk0-x236.google.com ([2607:f8b0:400c:c05::236]:33571)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <eswierk@skyportsystems.com>)
	id 1cYgXJ-000529-DO
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 17:04:25 -0500
Received: by mail-vk0-x236.google.com with SMTP id k127so246758679vke.0
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 14:04:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <d659ecc7-34a4-aad5-69c1-36ba4aff3d15@redhat.com>
References: <CAO_EM_kS-aGQdvPEO+7pkFWHOSiu8XMpZSduS=gPgUsDwJd9ig@mail.gmail.com>
	<20170127094033.GC26553@redhat.com>
	<CAO_EM_no14RDCd42hJy1xbo=mYsdo8k7oAESVx2KpF277U45VQ@mail.gmail.com>
	<20170131093927.GA20303@redhat.com>
	<d659ecc7-34a4-aad5-69c1-36ba4aff3d15@redhat.com>
From: Ed Swierk <eswierk@skyportsystems.com>
Date: Tue, 31 Jan 2017 14:03:44 -0800
Message-ID: <CAO_EM_ndhE1ibyHRyE3D_jSjs0PbX1wmetYTP6rvY_AM4Un8-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [libvirt] char: Logging serial pty output when
 disconnected
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org, libvir-list@redhat.com, marcandre.lureau@redhat.com, Eric Blake <eblake@redhat.com>

On Tue, Jan 31, 2017 at 7:34 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>
> On 31/01/2017 04:39, Daniel P. Berrange wrote:
>> I don't think so - retrying in this way is pointless IMHO - it is just
>> going to get the same result on every retry on 99% of occassions.
>
> Just to provide the full context, the retry happens even if you get
> EAGAIN, and in that case it does makes sense.
>
> But if the pty is disconnected I agree it should discard the data.

Thanks for the feedback. Please refer to this proposed patch:
http://patchwork.ozlabs.org/patch/721974/ .

--Ed
