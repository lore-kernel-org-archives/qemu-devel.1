Return-Path: <SRS0=kfsH=UP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF38C31E50
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 19:43:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECE1620870
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 19:43:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECE1620870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42528 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcb3V-0007D7-TB
	for qemu-devel@archiver.kernel.org; Sun, 16 Jun 2019 15:43:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45143)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <imammedo@redhat.com>) id 1hcb22-0006KL-SB
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 15:41:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1hcb21-00078q-JE
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 15:41:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54026)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hcb21-00077f-BF
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 15:41:37 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0523B81129;
 Sun, 16 Jun 2019 19:41:36 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EFADC19693;
 Sun, 16 Jun 2019 19:41:31 +0000 (UTC)
Date: Sun, 16 Jun 2019 21:41:27 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Message-ID: <20190616214127.20d1cd0e@redhat.com>
In-Reply-To: <9159f119-0a98-bb6b-93c1-de64a3b1580a@intel.com>
References: <20190508061726.27631-1-tao3.xu@intel.com>
 <20190508061726.27631-8-tao3.xu@intel.com>
 <20190604170456.5b3c198e@redhat.com>
 <729bde4a-bcb9-dac5-3a8a-04cc5f4d2bf9@intel.com>
 <20190605140841.63e8aa85@redhat.com>
 <02c9615a-fb59-664f-e878-124c9f43e54a@intel.com>
 <20190606184507.2c52cd41@redhat.com>
 <9159f119-0a98-bb6b-93c1-de64a3b1580a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Sun, 16 Jun 2019 19:41:36 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 07/11] hmat acpi: Build Memory Side
 Cache Information Structure(s) in ACPI HMAT
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "xiaoguangrong.eric@gmail.com" <xiaoguangrong.eric@gmail.com>,
 "mst@redhat.com" <mst@redhat.com>, "Liu, Jingqi" <jingqi.liu@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 10 Jun 2019 21:39:12 +0800
Tao Xu <tao3.xu@intel.com> wrote:

> On 6/7/2019 12:45 AM, Igor Mammedov wrote:
> > On Thu, 6 Jun 2019 11:00:33 +0800
> > Tao Xu <tao3.xu@intel.com> wrote:
> >  =20
> ...
> >>
> >> But the kernel HMAT can read othe Memory Side Cache Information except
> >> SMBIOS entries and the host HMAT tables also haven=E2=80=99t SMBIOS Ha=
ndles it
> >> also shows Number of SMBIOS handles (n) as 0. So I am wondering if it =
is
> >> better to setting "SMBIOS handles (n)" as 0, remove TODO and comment t=
he
> >> reason why set it 0? =20
> >=20
> > My understanding is that SMBIOS handles are used to associate side cache
> > descriptions with RAM pointed by SMBIOS handles, so that OS would be
> > able to figure out what RAM modules are cached by what cache.
> > Hence I suspect that side cache table is useless in the best case witho=
ut
> > valid references to SMBIOS handles.
> > (I might be totally mistaken but the matter requires clarification befo=
re
> > we commit to it)
> >  =20
>=20
> I am sorry for not providing a detailed description for Memory Side=20
> Cache use case. I will add more detailed description in next version of=20
> patch.
>=20
> As the commit message and /Documentation/admin-guide/mm/numaperf.rst of=20
> Kernel HMAT(listed blow), Memory Side Cache Structure is used to provide=
=20
> the cache information about System memory for the software to use. Then=20
> the software can maximize the performance because it can choose the best=
=20
> node to use.
>=20
> Memory Side Cache Information Structure and System Locality Latency and=20
> Bandwidth Information Structure can both provide more information than=20
> numa distance for software to see. So back to the SMBIOS, in spec,=20
> SMBIOS handles point to the memory side cache physical devices, but they=
=20
> are also information and not contribute to the performance of the=20
> described memory. The field "Proximity Domain for the Memory" can show=20
> the described memory.
>=20
> I am wondering if this explanation is clear? Thank you.

I didn't manage to find a definite answer in spec to what SMBIOS entry
should describe. Another use of 'Physical Memory Component' is in PMTT
table and it looks to me that it type 17 should reffer to DIMM device.

But well, considering spec isn't clear about subject and that linux
kernel doesn't seem to use this entries lets use it without SMBIOS
entries for now. Like you suggested, lets set number of SMBIOS handles to 0
and drop num_smbios_handles so that user won't be able to provide any.


> "System memory may be constructed in a hierarchy of elements with=20
> various performance characteristics in order to provide large address=20
> space of slower performing memory cached by a smaller higher performing=20
> memory."
>=20
> "An application does not need to know about caching attributes in order
> to use the system. Software may optionally query the memory cache
> attributes in order to maximize the performance out of such a setup.
> If the system provides a way for the kernel to discover this=20
> information, for example with ACPI HMAT (Heterogeneous Memory Attribute=20
> Table), the kernel will append these attributes to the NUMA node memory=20
> target."
>=20
> "Each cache level's directory provides its attributes. For example, the
> following shows a single cache level and the attributes available for
> software to query::
>=20
> 	# tree sys/devices/system/node/node0/memory_side_cache/
> 	/sys/devices/system/node/node0/memory_side_cache/
> 	|-- index1
> 	|   |-- indexing
> 	|   |-- line_size
> 	|   |-- size
> 	|   `-- write_policy
> "
>=20


