Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4418DCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 13:35:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10F0321929
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 13:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PXbbHk3s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10F0321929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNzks-0002ae-8o
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 09:35:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34305)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iNzcp-0000m6-QA
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:27:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iNzcn-0007dl-Mx
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:27:31 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59747
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iNzcn-0007cq-Bf
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:27:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572010046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+iCb/sdPv8Lz9A0cfrw/hI15X1udWcrq4pYJ5Ij4vU0=;
 b=PXbbHk3sS2HW0CTlcEsm+xZ3uW6tfv8CaIUil78dLJn+DtqRXTiw1l7KXeekEF6VQxDbKV
 cmwluY8vWH7EAPY2helNEFFslml7d9ipjObbm05jE1TY80h5sn0AD/OFD4EObqmD15ZQ2s
 6IyX9JbpWgGc+shH2yK0Zg67NyEEaHQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-HMEe2cjQMPKtepDcOB5g5g-1; Fri, 25 Oct 2019 09:27:24 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC17A47B;
 Fri, 25 Oct 2019 13:27:23 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4541F60BF4;
 Fri, 25 Oct 2019 13:27:22 +0000 (UTC)
Date: Fri, 25 Oct 2019 15:27:20 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH v13 06/12] numa: Extend CLI to provide memory latency
 and bandwidth information
Message-ID: <20191025152720.4068bfae@redhat.com>
In-Reply-To: <9e30d8fe-7274-4ee8-3c4b-64c370141358@intel.com>
References: <20191020111125.27659-1-tao3.xu@intel.com>
 <20191020111125.27659-7-tao3.xu@intel.com>
 <20191023172854.42c495d5@redhat.com>
 <9e30d8fe-7274-4ee8-3c4b-64c370141358@intel.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: HMEe2cjQMPKtepDcOB5g5g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>, "Liu,
 Jingqi" <jingqi.liu@intel.com>, "Du, Fan" <fan.du@intel.com>,
 Markus Armbruster <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 25 Oct 2019 14:33:53 +0800
Tao Xu <tao3.xu@intel.com> wrote:

> On 10/23/2019 11:28 PM, Igor Mammedov wrote:
> > On Sun, 20 Oct 2019 19:11:19 +0800
> > Tao Xu <tao3.xu@intel.com> wrote: =20
> [...]
> >> +#
> >> +# @access-bandwidth: access bandwidth (MB/s)
> >> +#
> >> +# @read-bandwidth: read bandwidth (MB/s)
> >> +#
> >> +# @write-bandwidth: write bandwidth (MB/s) =20
> > I think units here are not appropriate, values stored in fields are
> > minimal base units only and nothing else (i.e. ps and B/s)
> >  =20
> Eric suggest me to drop picoseconds. So here I can use ns. For=20
> bandwidth, if we use B/s here, does it let user or developer to=20
> misunderstand that the smallest unit is B/s ?

It's not nanoseconds or MB/s stored in theses fields, isn't it?
I'd specify units in which value is stored or drop units altogether.

Maybe Eric and Markus can suggest a better way to describe fields.

> >>   @item -numa node[,mem=3D@var{size}][,cpus=3D@var{firstcpu}[-@var{las=
tcpu}]][,nodeid=3D@var{node}][,initiator=3D@var{initiator}]
> >>   @itemx -numa node[,memdev=3D@var{id}][,cpus=3D@var{firstcpu}[-@var{l=
astcpu}]][,nodeid=3D@var{node}][,initiator=3D@var{initiator}]
> >>   @itemx -numa dist,src=3D@var{source},dst=3D@var{destination},val=3D@=
var{distance}
> >>   @itemx -numa cpu,node-id=3D@var{node}[,socket-id=3D@var{x}][,core-id=
=3D@var{y}][,thread-id=3D@var{z}]
> >> +@itemx -numa hmat-lb,initiator=3D@var{node},target=3D@var{node},hiera=
rchy=3D@var{str},data-type=3D@var{str}[,latency=3D@var{lat}][,bandwidth=3D@=
var{bw}] =20
> >                                                                        =
        ^^^                 ^^^
> > Using the same 'str' for 2 different enums is confusing.
> > Suggest for 1st use 'level' and for the second just 'type'
> >  =20
> Ok
>=20
> >>   @findex -numa
> >>   Define a NUMA node and assign RAM and VCPUs to it.
> >>   Set the NUMA distance from a source node to a destination node.
> >> +Set the ACPI Heterogeneous Memory Attributes for the given nodes.
> >>  =20
> >>   Legacy VCPU assignment uses @samp{cpus} option where
> >>   @var{firstcpu} and @var{lastcpu} are CPU indexes. Each
> >> @@ -256,6 +259,50 @@ specified resources, it just assigns existing res=
ources to NUMA
> >>   nodes. This means that one still has to use the @option{-m},
> >>   @option{-smp} options to allocate RAM and VCPUs respectively.
> >>  =20
> >> +Use @samp{hmat-lb} to set System Locality Latency and Bandwidth Infor=
mation
> >> +between initiator and target NUMA nodes in ACPI Heterogeneous Attribu=
te Memory Table (HMAT).
> >> +Initiator NUMA node can create memory requests, usually including one=
 or more processors. =20
> > s/including/it has/
> >  =20
> >> +Target NUMA node contains addressable memory.
> >> +
> >> +In @samp{hmat-lb} option, @var{node} are NUMA node IDs. @var{str} of =
'hierarchy'
> >> +is the memory hierarchy of the target NUMA node: if @var{str} is 'mem=
ory', the structure
> >> +represents the memory performance; if @var{str} is 'first-level|secon=
d-level|third-level',
> >> +this structure represents aggregated performance of memory side cache=
s for each domain.
> >> +@var{str} of 'data-type' is type of data represented by this structur=
e instance:
> >> +if 'hierarchy' is 'memory', 'data-type' is 'access|read|write' latenc=
y(nanoseconds) =20
> > is nanoseconds is right here? Looking at previous patches default value=
 of suffix-less
> > should be picoseconds. I'd just drop '(nanoseconds)'. User will use app=
ropriate suffix.
> >  =20
> OK, I will drop it.
> >> +or 'access|read|write' bandwidth(MB/s) of the target memory; if 'hier=
archy' is =20
> > ditto (MB/s), probably should be Bytes/s for default suffix-less value
> > (well, I'm not sure how to express it better)
> >  =20
>=20
> But last version, we let !QEMU_IS_ALIGNED(node->bandwidth, MiB) as error.
it's alignment requirement and it doesn't mean that value could not be
represented in bytes/s.
And it is bytes/s if suffix isn't used.

As for alignment and precision of values you probably need to document
expectations here as well.

> >> +'first-level|second-level|third-level', 'data-type' is 'access|read|w=
rite' hit latency
> >> +or 'access|read|write' hit bandwidth of the target memory side cache.
> >> +
> >> +@var{lat} of 'latency' is latency value, the possible value and units=
 are
> >> +NUM[ps|ns|us] (picosecond|nanosecond|microsecond), the recommended un=
it is 'ns'. @var{bw}
> >> +is bandwidth value, the possible value and units are NUM[M|G|T], mean=
 that =20
> >  =20
> >> +the bandwidth value are NUM MB/s, GB/s or TB/s. Note that max NUM is =
65534,
> >> +if NUM is 0, means the corresponding latency or bandwidth information=
 is not provided.
> >> +And if input numbers without any unit, the latency unit will be 'ps' =
and the bandwidth
> >> +will be MB/s. =20
> >   1st: above is applicable to both bw and lat values and should be docu=
mented as such
> >   2nd: 'max NUM is 65534' when different suffixes is fleeting target,
> >        spec says that entry with 0xFFFF is unreachable, so how about do=
cumenting
> >        unreachable value as 0xFFFFFFFFFFFFFFFF (then CLI parsing code w=
ill
> >        exclude it from range detection and acpi table building code tra=
nslate it
> >        to internal 0xFFFF it could fit into the tables)
> >  =20
>=20
> If we input 0xFFFFFFFFFFFFFFFF, qemu will raise error that parameter=20
> expect a size value.

opts_type_size() can't handle values >=3D 0xfffffffffffffc00

commit f46bfdbfc8f (util/cutils: Change qemu_strtosz*() from int64_t to uin=
t64_t)

so behavior would change depending on if the value is parsed by CLI (size) =
or QMP (unit64) parsers.

we can cannibalize 0x0 as the unreachable value and an absent bandwidth/lat=
 option
for not specified case.
It would be conflicting with matrix [1] values in spec, but CLI/QMP deals w=
ith
absolute values which are later processed into HMAT substructure.

Markus,
Can we make opts_type_size() handle full range of uint64_t?

1)
ACPI 6.3 spec:
5.2.27.4 System Locality Latency and Bandwidth Information Structure


