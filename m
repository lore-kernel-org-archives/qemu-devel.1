Received: from eggs.gnu.org ([209.51.188.92]:46392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fam@euphon.net>) id 1h3X06-0007Gy-Ny
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 22:18:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fam@euphon.net>) id 1h3X05-00081P-TR
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 22:18:42 -0400
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
From: Fam Zheng <fam@euphon.net>
In-Reply-To: <20190311110631.GC7899@localhost.localdomain>
Date: Tue, 12 Mar 2019 10:18:11 +0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <D98F73B7-A06F-4046-8847-F5165F766E92@euphon.net>
References: <1545387387-9613-1-git-send-email-baiyaowei@cmss.chinamobile.com>
	<20190306215633.GM6818@localhost.localdomain>
	<20190307084405.GB26350@byw>
	<20190307112505.GB5786@linux.fritz.box> <20190308072230.GA9529@byw>
	<20190308100826.GB5339@localhost.localdomain>
	<20190309014648.GA28010@byw>
	<20190311110631.GC7899@localhost.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] tcmu: Introduce qemu-tcmu
 utility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Fam Zheng <fam@euphon.net>, Yaowei Bai <baiyaowei@cmss.chinamobile.com>, stefanha <stefanha@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Amar Tumballi <atumball@redhat.com>, Mike Christie <mchristi@redhat.com>, Prasanna Kalever <pkalever@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Xiubo Li <xiubli@redhat.com>



> On Mar 11, 2019, at 19:06, Kevin Wolf <kwolf@redhat.com> wrote:
>=20
> Am 09.03.2019 um 02:46 hat Yaowei Bai geschrieben:
>> Thanks for explaining the background. It comes to my mind that =
actually we
>> talked about these two cases with Fam a bit long time ago and decided =
to
>> support both these two cases. The reason why we implement case2 first =
is
>> currently we care more about exporting new opened images and it's a =
bit
>> more convenient, exporting from a VM or QMP can be added in the later
>> release. Do you think it's reasonable/acceptable that we support both
>> cases and use case2 for normal new opened images and case1 for the
>> circumstances you mention above?
>=20
> I would like to avoid a second code path because it comes with a
> maintenance cost.
>=20
> Experience also tells that adding a new way to parse option strings =
will
> come back at us later because it we must always maintain compatibility
> with yet another format.

If the rule is that cfgstr strictly follows -blockdev syntax and the =
parsing code is mostly shared, it shouldn=E2=80=99t be a problem, right? =
I suppose this will limit the expressiveness of cfgstr but might be a =
reasonable tradeoff between implementation complexity, user friendliness =
and interface consistency.

Another possibility is to use json: format in cfgstr for anything more =
complex than a single -blockdev.

>=20
> So I would prefer not doing this and just passing command line options
> to qemu-tcmu, which can reuse the already existing code paths.

I think the effect of not supporting adding new blockdev from cfgstr is =
that we have to resort to QMP to allow hot-adding targets. It=E2=80=99s =
not necessarily bad, though I=E2=80=99m not sure hwo that aligns with =
Yaowei=E2=80=99s development plan.

Fam


>=20
> Kevin
>=20
