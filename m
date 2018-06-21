Received: from eggs.gnu.org ([2001:4830:134:3::10]:37118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fVxgu-00087D-Ib
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 07:23:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fVxgq-00067j-Ua
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 07:23:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47606 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fVxgq-00067M-Pf
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 07:23:48 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180621083551.775-1-armbru@redhat.com>
	<20180621091831.GF3615@redhat.com>
Date: Thu, 21 Jun 2018 13:23:47 +0200
In-Reply-To: <20180621091831.GF3615@redhat.com> ("Daniel P. =?utf-8?Q?Berr?=
	=?utf-8?Q?ang=C3=A9=22's?=
	message of "Thu, 21 Jun 2018 10:18:31 +0100")
Message-ID: <877emso01o.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qapi: Fix some pycodestyle-3 complaints
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Thu, Jun 21, 2018 at 10:35:51AM +0200, Markus Armbruster wrote:
>> Fix the following issues:
>>=20
>>     common.py:873:13: E129 visually indented line with same indent as ne=
xt logical line
>>     common.py:1766:5: E741 ambiguous variable name 'l'
>>     common.py:1784:1: E305 expected 2 blank lines after class or functio=
n definition, found 1
>>     common.py:1833:1: E305 expected 2 blank lines after class or functio=
n definition, found 1
>>     common.py:1843:1: E305 expected 2 blank lines after class or functio=
n definition, found 1
>>     visit.py:181:18: E127 continuation line over-indented for visual ind=
ent
>>=20
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  scripts/qapi/common.py | 15 +++++++++------
>>  scripts/qapi/visit.py  |  2 +-
>>  2 files changed, 10 insertions(+), 7 deletions(-)
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
>
> If we care about pycodestyle-3 compliance, it is probably worth adding
> that to 'make check' to avoid people introducing regressions.

It's not spotless, yet:

$ pycodestyle-3 scripts/qapi-gen.py scripts/qapi/*.py
scripts/qapi/commands.py:66:80: E501 line too long (93 > 79 characters)
scripts/qapi/common.py:818:49: E261 at least two spaces before inline comme=
nt
scripts/qapi/visit.py:24:80: E501 line too long (86 > 79 characters)
scripts/qapi/visit.py:117:80: E501 line too long (88 > 79 characters)
scripts/qapi/visit.py:154:80: E501 line too long (87 > 79 characters)
scripts/qapi/visit.py:167:80: E501 line too long (88 > 79 characters)
scripts/qapi/visit.py:237:80: E501 line too long (88 > 79 characters)

The long lines are in mcgen() arguments.

If cleaning these up is the price for automation, I guess we'll pay it.

Thanks!
