Received: from eggs.gnu.org ([209.51.188.92]:47210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.kanda@oracle.com>) id 1gzCqq-0006aJ-BB
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 22:59:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.kanda@oracle.com>) id 1gzCqn-0000qM-JQ
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 22:59:14 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:45382)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.kanda@oracle.com>)
	id 1gzCqn-0000Ov-8O
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 22:59:13 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x1S3wowK186842
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 03:58:50 GMT
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
	by userp2130.oracle.com with ESMTP id 2qtwkuemgx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 03:58:50 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1S3wnPA005119
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK) for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 03:58:50 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1S3wnmf024371
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 03:58:49 GMT
References: <b83ee802-1f9a-f379-f1bf-4e13bfd8a94f@oracle.com>
From: Mark Kanda <mark.kanda@oracle.com>
Message-ID: <9d62856a-0148-d3a2-6401-c8ff29b71ed3@oracle.com>
Date: Wed, 27 Feb 2019 21:58:48 -0600
MIME-Version: 1.0
In-Reply-To: <b83ee802-1f9a-f379-f1bf-4e13bfd8a94f@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Nested SVM only enabled (by default) in
 pc-i440fx-2.1?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 2/27/2019 4:05 PM, Mark Kanda wrote:
> Hi all,
>=20
> I noticed nested SVM is enabled only in pc-i440fx-2.1 (default is=20
> disabled); this was added when 2.1 was the latest:
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A075d373ef97 ("target-i386: Disable SVM by defau=
lt in KVM mode")
>=20
> However, this change was not carried forward to newer machine types. Is=
=20
> this an oversight? Is there a reason we (still) need SVM disabled by=20
> default?

To clarify, it's my understanding the above patch was added to disable=20
nested SVM in pc-i440fx-2.2 (and future) machine types due to stability=20
issues (while keeping it enabled in pc-i440fx-2.1 and previous machine=20
types).

I'm wondering if nested SVM is now mature enough to remove this=20
restriction and enable it by default (at least on recent machine types).

Thanks/regards,
-Mark
