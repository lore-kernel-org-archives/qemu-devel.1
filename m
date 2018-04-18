Received: from eggs.gnu.org ([2001:4830:134:3::10]:48432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f8ozx-00049N-Dw
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 11:27:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f8ozs-0005zG-D6
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 11:27:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44138 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1f8ozs-0005ye-8u
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 11:27:48 -0400
References: <20180417224054.26363-1-lersek@redhat.com>
	<c5e3f942-2c0e-9809-32ae-df97eaf2b7cd@redhat.com>
	<762b3dc8-a86f-a21f-1e21-334ec46677ef@redhat.com>
	<20180418120320.GH27579@redhat.com>
	<f16c1406-78ac-d275-63e9-90de3beac9f0@redhat.com>
	<b0d8036a-4ce0-de5c-88ac-28360658e1e2@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <e11087c0-1a4c-3f01-c93f-c12657f40eae@redhat.com>
Date: Wed, 18 Apr 2018 17:27:32 +0200
MIME-Version: 1.0
In-Reply-To: <b0d8036a-4ce0-de5c-88ac-28360658e1e2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu RFC v2] qapi: add "firmware.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, libvir-list@redhat.com, Alexander Graf <agraf@suse.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, David Gibson <dgibson@redhat.com>, Gary Ching-Pang Lin <glin@suse.com>, Gerd Hoffmann <kraxel@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Michal Privoznik <mprivozn@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>

On 04/18/18 17:17, Eric Blake wrote:
> On 04/18/2018 07:40 AM, Laszlo Ersek wrote:
> 
>> Is it guaranteed that lists in JSON keep the order of the elements?
>> Because, dictionaries definitely don't promise any ordering between the
>> keys.
> 
> Yes, JSON lists preserve order (and we have to explicitly document cases
> where order within a list is not significant).
> 

Thanks.

After digesting the comments on @type for a while longer, from Dan, Gerd
and Paolo, I think we *should* keep @type, but rather than having it be
a simple enum, let's make it a list of enums, where order matters. Keep
@features separate, and document that order does not matter there.

Here's why: my brain is crashing trying to come up with a
human-parseable explanation why for *some* entries in @features, their
relative order is important, and why for some others, it isn't.
Discerning the subset for which order matters, from any specific
grab-bag of @features, will be no fun for the human user.

Given that the "ordered features" idea was brought to life solely
because a firmware can provide multiple interfaces (with a strong
preference order between them), I guess we might as well be honest about
that, and update @type accordingly.

Thoughts? :)

Thanks,
Laszlo
