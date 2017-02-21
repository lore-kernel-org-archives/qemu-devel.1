Received: from eggs.gnu.org ([2001:4830:134:3::10]:47151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cgAxO-0002G0-VN
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 08:58:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cgAxO-0003jo-D6
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 08:58:19 -0500
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:35383)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cgAxO-0003iC-75
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 08:58:18 -0500
Received: by mail-wr0-x233.google.com with SMTP id s27so35717225wrb.2
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 05:58:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87poibr6kv.fsf@dusky.pond.sub.org>
References: <1487357795-52614-1-git-send-email-imammedo@redhat.com>
	<CAFEAcA9JWzUEmGa2Wxd5xPE4dVknOKBkt=wMda7CAgxzrgOc+w@mail.gmail.com>
	<20170220195500.332a4844@nial.brq.redhat.com>
	<CAFEAcA-VAY8LM+8jE4B-L=0QdcY5FLvwmwGVbUhcXjnC9-AW+w@mail.gmail.com>
	<20170221134416.5803b3e5@nial.brq.redhat.com>
	<CAFEAcA-MggU5T1fO8GonkSpLF0SNe0jtygEHtEBkpWC8hyShSw@mail.gmail.com>
	<87poibr6kv.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Feb 2017 13:57:56 +0000
Message-ID: <CAFEAcA-75VPiOzPauZO4ukYVYWffB1cu1-tsQs6Hs8m8Vf41OQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [RFC 0/3] generalize parsing of cpu_model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, "patches@linaro.org" <patches@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On 21 February 2017 at 13:56, Markus Armbruster <armbru@redhat.com> wrote:
> -global is a qdev thing.

...which reminds me to ask: is there any hope for unifying
our properties so we don't have both "qdev properties" and
"qom properties" or are we doomed to two distinct sets of
APIs forever?

thanks
-- PMM
