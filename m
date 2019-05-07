Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02946C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 21:02:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEB5920656
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 21:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="v+Qmli9e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEB5920656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54827 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO7EQ-0005zD-Qx
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 17:02:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1hO7D5-0005Or-NK
	for qemu-devel@nongnu.org; Tue, 07 May 2019 17:01:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elena.ufimtseva@oracle.com>) id 1hO7D4-0001Xa-6j
	for qemu-devel@nongnu.org; Tue, 07 May 2019 17:01:11 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:38718)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
	id 1hO7D3-0001T1-UM
	for qemu-devel@nongnu.org; Tue, 07 May 2019 17:01:10 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
	by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x47Ksh0G194161; Tue, 7 May 2019 21:01:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=date : from : to : cc
	: subject : message-id : references : mime-version : content-type :
	content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
	bh=tG/KjFqJtdG8nOjI2W4agNJqpTTq6CQOtExGIYh2Ezs=;
	b=v+Qmli9ePhLxPh9KkKZTo3u6DccMxh+D3dJ5+bP9BIsfDZbqcooyOybtyH2CzFsajx1l
	JhPhQbC6sQVnQaK5JNgjsL0l4Px/NzXbOkmvPfBi7qXgYVBS4pjl46D4j45M8888URW7
	yMve64A9j//1TsF0VuCTHEBG6t4z+zkG0Lw1ssL4Xc48DeYlLzqE3fRUg1VSAmo+JJTV
	JeAE+4nYxN4GmnV3QwNNcT4TGLT6B+issQdfbKj+vgQvMA2Gz0dFJ2OhmO9tHbeqaGXz
	crWfuW4t3gdszL71j0xFGhfjKS56yKajQFD9JiOJaY554iPo+ysz240ih7oFr2dqwMO4
	QA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
	by aserp2130.oracle.com with ESMTP id 2s94b603gs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2019 21:01:04 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
	by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x47KxsaC192796; Tue, 7 May 2019 21:01:03 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by userp3030.oracle.com with ESMTP id 2sagyu5vga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2019 21:01:03 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x47L12V8022444;
	Tue, 7 May 2019 21:01:02 GMT
Received: from heatpipe (/73.170.27.202)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Tue, 07 May 2019 14:01:01 -0700
Date: Tue, 7 May 2019 14:00:59 -0700
From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190507210059.GA26233@heatpipe>
References: <20190307072253.9868-1-elena.ufimtseva@oracle.com>
	<20190307142609.GF2843@stefanha-x1.localdomain>
	<20190307145120.GF32268@redhat.com>
	<20190307192727.GG2915@stefanha-x1.localdomain>
	<BDEBF2EE-DE0F-46CF-B60E-536B3DA9BF77@oracle.com>
	<20190311102006.GK12393@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190311102006.GK12393@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9250
	signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1905070131
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9250
	signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1905070131
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by aserp2130.oracle.com id
	x47Ksh0G194161
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.79
Subject: Re: [Qemu-devel] [multiprocess RFC PATCH 36/37] multi-process: add
 the concept description to docs/devel/qemu-multiprocess
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: John G Johnson <john.g.johnson@oracle.com>, sstabellini@kernel.org,
	Jag Raman <jag.raman@oracle.com>, konrad.wilk@oracle.com,
	Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
	ross.lagerwall@citrix.com, liran.alon@oracle.com,
	Stefan Hajnoczi <stefanha@redhat.com>, kanth.ghatraju@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 11, 2019 at 10:20:06AM +0000, Daniel P. Berrang=C3=A9 wrote:
> On Thu, Mar 07, 2019 at 03:29:41PM -0800, John G Johnson wrote:
> >=20
> >=20

Hi Daniel, Stefan

We have not replied in a while as we were trying to figure out
the best approach after multiple comments we have received on the
patch series.

Leaving other concerns that you, Stefan and others shared with us
out of this particular topic, we would like to get your opinion on
the following approach.

Please see below.

> > > On Mar 7, 2019, at 11:27 AM, Stefan Hajnoczi <stefanha@redhat.com> =
wrote:
> > >=20
> > > On Thu, Mar 07, 2019 at 02:51:20PM +0000, Daniel P. Berrang=C3=A9 w=
rote:
> > >> I guess one obvious answer is that the existing security mechanism=
s like
> > >> SELinux/ApArmor/DAC can be made to work in a more fine grained man=
ner if
> > >> there are distinct processes. This would allow for a more useful s=
eccomp
> > >> filter to better protect against secondary kernel exploits should =
QEMU
> > >> itself be exploited, if we can protect individual components.
> > >=20
> > > Fine-grained sandboxing is possible in theory but tedious in practi=
ce.
> > > From what I can tell this patch series doesn't implement any sandbo=
xing
> > > for child processes.
> > >=20
> >=20
> > 	The policies aren=E2=80=99t in QEMU, but in the selinux config files.
> > They would say, for example, that when the QEMU process exec()s the
> > disk emulation process, the process security context type transitions
> > to a new type.  This type would have permission to access the VM imag=
e
> > objects, whereas the QEMU process type (and any other device emulatio=
n
> > process types) cannot access them.
>=20
> Note that currently all QEMU instances run by libvirt have seccomp
> policy applied that explicitly forbids any use of fork+exec as a way
> to reduce avenues of attack for an exploited QEMU.
>=20
> Even in a modularized QEMU I'd be loathe to allow QEMU to have the
> fork+exec privileged, unless "QEMU" in this case was just a stub
> process that does nothing more than fork+exec the other binaries,
> while having zero attack exposed to the untrusted guest OS.

We see libvirt uses QEMU=E2=80=99s -sandbox option to indicate that QEMU
should use seccomp() to prohibit future use of certain system calls,
including fork() and exec().  Our idea is to enumerate the remote
processes needed via QEMU command line options, and have QEMU exec()
those processes before -sandbox is processed.
And we also will init seccomp for emulated devices processes.

>=20
> > 	If you wanted to use DAC, you could do the something similar by
> > making the disk emulation executable setuid to a UID than can access
> > VM image files.
> >=20
> > 	In either case, the policies and permissions are set up before
> > libvirt even runs, so it doesn=E2=80=99t need to be aware of them.
>=20
> That's not the case bearing in mind the above point about fork+exec
> being forbidden. It would likely require libvirt to be in charge of
> spawning the various helper binaries from a trusted context.
>=20
>=20
> > > How to do this in practice must be clear from the beginning if
> > > fine-grained sandboxing is the main selling point.
> > >=20
> > > Some details to start the discussion:
> > >=20
> > > * How will fine-grained SELinux/AppArmor/DAC policies be configured=
 for
> > >   each process?  I guess this requires root, so does libvirt need t=
o
> > >   know about each process?
> > >=20
> >=20
> > 	The polices would apply to process security context types (or
> > UIDs in a DAC regime), so I would not expect libvirt to be aware of t=
hem.
>=20
> I'm pretty skeptical that such a large modularization of QEMU can be
> done without libvirt being aware of it & needing some kind of changes
> applied.
>

We agree with that. With above proposed approach we still have to change =
hotplug
in some way.
If a eparate process will be spawned, libvirt will be the one doing
fork/exec of the separate processes. Or possibly launch a helper
binaries that will unify the way how an instance is being started with
multiple processes and hotplugging.

Thanks!
Elena, Jag, John.


>=20
> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|

