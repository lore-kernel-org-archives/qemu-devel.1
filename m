Received: from eggs.gnu.org ([209.51.188.92]:47532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hEENt-0007ab-09
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 10:39:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hEENs-0006Gz-0Y
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 10:39:28 -0400
References: <cover.1554755001.git.stephen.checkoway@oberlin.edu>
	<c03b48badb28e3c98bcbaed092b5c40e7284db08.1554755001.git.stephen.checkoway@oberlin.edu>
	<9409d9bf-c513-d82b-d438-9173fc582d7f@redhat.com>
	<98B3F0C7-6554-4455-B441-86605DA5D6C1@oberlin.edu>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c3d9ce6b-25d0-940a-7236-5b51a4d99bdc@redhat.com>
Date: Wed, 10 Apr 2019 16:39:21 +0200
MIME-Version: 1.0
In-Reply-To: <98B3F0C7-6554-4455-B441-86605DA5D6C1@oberlin.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 01/10] block/pflash_cfi02: Add test for
 supported commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stephen Checkoway <stephen.checkoway@oberlin.edu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 09/04/2019 17.37, Stephen Checkoway wrote:
>=20
>=20
> On Apr 9, 2019, at 02:13, Thomas Huth <thuth@redhat.com> wrote:
>=20
>> We'd like to get rid of global_qtest in the long run (since it is
>> causing trouble for tests that run multiple instances of QEMU in
>> parallel, e.g. migration tests)... so if it is feasible, please don't
>> use it in new code anymore. Try to use a local variable in the functio=
n
>> that call qtest_initf() and pass the test state around via a parameter
>> to the functions that need it.
>=20
> One of the patches introduces a FlashConfig structure which gets passed=
 around to all the functions. I could stuff the local qtest in there. The=
 earlier patches would still use global_qtest. Would that be acceptable o=
r would you prefer that global_qtest not appear in any of the patches?

Using FlashConfig sounds fine to me. If you need to use global_qtest in
some of the earlier patches, that's ok, too (especially if these go away
again in the later patches ;-)).

 Thomas
