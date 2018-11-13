Received: from eggs.gnu.org ([2001:4830:134:3::10]:52666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gMZt2-0004Ii-6j
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 09:41:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gMZsu-0007vt-Hy
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 09:41:47 -0500
References: <20181109221213.7310-1-crosa@redhat.com>
	<20181112104953.GB11580@linux.fritz.box>
	<f1c27ed2-9aba-edaf-2c49-ff565a0847ce@redhat.com>
	<20181112160025.GE11580@linux.fritz.box>
	<b51dd4e4-e814-db42-86be-698c0d87f8ef@redhat.com>
	<875zx18geq.fsf@dusky.pond.sub.org> <20181113135024.GI14591@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <80d0e452-61c2-7952-9c34-ef8529c10348@redhat.com>
Date: Tue, 13 Nov 2018 09:41:07 -0500
MIME-Version: 1.0
In-Reply-To: <20181113135024.GI14591@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 0/2] Acceptance tests for qemu-img
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, Caio Carrara <ccarrara@redhat.com>, qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>



On 11/13/18 8:50 AM, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Nov 13, 2018 at 10:39:57AM +0100, Markus Armbruster wrote:
>> Drive-by comment...
>>
>> Cleber Rosa <crosa@redhat.com> writes:
>>
>> [...]
>>> My impression is that the "infrastructure for block tests" is not tha=
t
>>> different from the infrastructure needed by other tests, specially ot=
her
>>> QEMU tests.
>> [...]
>>
>> Yes.  The actual reason for having a completely separate testing
>> infrastructure for block tests is that it predates testing
>> infrastructure for anything else.
>>
>> Moving the tests to common infrastructure would be a sizable one-time
>> effort we can ill afford.  Maintaining multiple testing infrastructure=
s
>> is an ongoing effort we can also ill afford.
>=20
> If we do want to move to a common infrastructure, then IMHO this patch
> series should do the work to convert qemu-iotests to use it.
>=20
> Currently this is simply introducing a 2nd way to write block tests.
>=20
> We know from bitter experiance that when we introduce a new system in
> QEMU without converting the old system, the old system will live foreve=
r
> increasing our maint burden & creatnig confusion for developers about
> which is the preferred approach.
>=20
>=20
> Regards,
> Daniel
>=20

Right, I don't think there's enough momentum or interest in doing that
right now.  As myself and Kevin suggested, the best solution at this
point may be wrapping the qemu-iotests without touching them.

Regards,
- Cleber.
