Received: from eggs.gnu.org ([2001:4830:134:3::10]:47390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fRAni-0005Zg-BV
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 02:23:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fRAnf-0001U2-7a
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 02:23:06 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180607144645.10187-1-f4bug@amsat.org>
	<20180607144645.10187-3-f4bug@amsat.org>
	<20180608030319.GE3344@umbus.fritz.box>
	<83125664-91ec-3274-e6d3-6c5ccfd95297@amsat.org>
	<20180608042316.GP3344@umbus.fritz.box>
Date: Fri, 08 Jun 2018 08:22:59 +0200
In-Reply-To: <20180608042316.GP3344@umbus.fritz.box> (David Gibson's message
	of "Fri, 8 Jun 2018 14:23:16 +1000")
Message-ID: <87d0x1bxvg.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/4] hw/ppc/spapr_drc: Replace
 error_setg(&error_abort) by abort()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org

David Gibson <david@gibson.dropbear.id.au> writes:

> On Fri, Jun 08, 2018 at 12:54:36AM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:
>> Hi David,
>>=20
>> On 06/08/2018 12:03 AM, David Gibson wrote:
>> > On Thu, Jun 07, 2018 at 11:46:43AM -0300, Philippe Mathieu-Daud=C3=A9 =
wrote:
>> >> Use abort() instead of error_setg(&error_abort),
>> >> as suggested by the "qapi/error.h" documentation:
>> >>
>> >>     Please don't error_setg(&error_fatal, ...), use error_report() and
>> >>     exit(), because that's more obvious.
>> >>     Likewise, don't error_setg(&error_abort, ...), use assert().
>> >>
>> >> Use abort() instead of the suggested assert() because the assertion is
>> >> already verified by the switch case.
>> >=20
>> > I think g_assert_not_reached() would be the right thing here.
>>=20
>> I try to follow Eric advice (who recalled Markus).
>> As I understand:
>> http://lists.gnu.org/archive/html/qemu-devel/2017-08/msg03605.html
>>=20
>> "glib-Testing [...] should not be used outside of tests/."
>
> Oh, ok, go with that then.

Most g_assert_FOO() are indeed tests-only, but g_assert_not_reached() is
actually acceptable elsewhere, see commit 6e9389563e5, and its review
thread
https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg05499.html
Message-Id: <20170427165526.19836-1-dgilbert@redhat.com>

That said, I fail to see the value of this kind of lipstick, too.

> Acked-by: David Gibson <david@gibson.dropbear.id.au>
>
>> I can respin if you prefer.

I can replace by g_assert_not_reached() on commit if you prefer.
