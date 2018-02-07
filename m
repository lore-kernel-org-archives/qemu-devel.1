Received: from eggs.gnu.org ([2001:4830:134:3::10]:53651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ciro.santilli@gmail.com>) id 1ejOdm-0002aF-UL
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:15:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ciro.santilli@gmail.com>) id 1ejOdk-0002Wt-Fj
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:15:53 -0500
Received: from mail-it0-x22b.google.com ([2607:f8b0:4001:c0b::22b]:35818)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ciro.santilli@gmail.com>)
	id 1ejOdk-0002WX-AS
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:15:52 -0500
Received: by mail-it0-x22b.google.com with SMTP id e1so1997725ita.0
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 04:15:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180207120353.5389.54531.stgit@pasha-VirtualBox>
References: <20180207120353.5389.54531.stgit@pasha-VirtualBox>
From: Ciro Santilli <ciro.santilli@gmail.com>
Date: Wed, 7 Feb 2018 12:15:30 +0000
Message-ID: <CAFXrp_fenK2mzLSOUUcWLTR1r4_jUEN07QDqfkRDpTFEo4oHpQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v6 00/20] replay additions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, boost.lists@gmail.com, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, thomas.dullien@googlemail.com, pbonzini@redhat.com, alex.bennee@linaro.org

On Wed, Feb 7, 2018 at 12:03 PM, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
wrote:

> This set of patches moves replay lock upper in the function call tree.
> Now replay lock functions similar to BQL in older version and allows
> deterministic execution of the threads in icount mode.
> It is also fixes some vmstate creation (and loading) issues
> in record/replay modes:
>  - VM start/stop fixes in replay mode
>  - overlay creation for blkreplay filter
>  - fixes for vmstate save/load in record/replay mode
>  - fixes for host clock vmstate
>
> There is also a set of helper scripts written by Alex Benn=C3=A9e
> for debugging the record/replay code.
>
>
Can you provide a test branch somewhere so I can easily test it out?

Thanks
