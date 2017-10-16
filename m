Received: from eggs.gnu.org ([2001:4830:134:3::10]:58810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@fritscher.net>) id 1e3y09-00054c-Oh
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 01:31:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@fritscher.net>) id 1e3y06-0002VW-KN
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 01:31:45 -0400
Received: from mifritscher.de ([188.40.170.105]:58664
	helo=mail.mifritscher.vserverkompetenz.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@fritscher.net>)
	id 1e3y06-0002Ul-E0
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 01:31:42 -0400
Message-ID: <c5422d95248bbc83fb27c0b992f85aad.squirrel@mifritscher.de>
In-Reply-To: <20171015215055.19dbecc1@bahia.lan>
References: <20170929111323.6308-1-michael@fritscher.net>
	<c6489dce-108d-e163-589d-11e6f2c227da@redhat.com>
	<c507f03f377b2496da5e08af037a14ee.squirrel@mifritscher.de>
	<497f0cbe-3441-ae6b-ad25-0ebc092318cc@redhat.com>
	<693169b0c0e3904c935db314432bf671.squirrel@mifritscher.de>
	<f43e0c376d23066ee08736c43f99100d.squirrel@mifritscher.de>
	<20171015215055.19dbecc1@bahia.lan>
Date: Mon, 16 Oct 2017 07:31:38 +0200
From: "Michael Fritscher" <michael@fritscher.net>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Make 9pfs buildable for Windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Michael Fritscher <michael@fritscher.net>, Paolo Bonzini <pbonzini@redhat.com>, sw@weilnetz.de, aneesh.kumar@linux.vnet.ibm.com, mst@redhat.com, qemu-devel@nongnu.org, gkurz@linux.vnet.ibm.com

>> I see one thing: symlinks somewhere in the path (which seemed to be th=
e
>> reason introducing the *at family). But I think that this can be handl=
ed
>> by canonlizing the path, too. realpath should do the job quite well.
>>
>
> Unfortunately now because we have TOCTOU condition here: some path elem=
ent
> could be replaced by a symlink after realpath() but before we actually
> pass
> the resulting path to a syscall.
>

Hi,

my mistake was that thinking that O_NOFOLLOW prevents following any
symlink in the path, but it prevents only following if the pathname itsel=
f
is a symlink...

Best regards,
Michael Frischer
