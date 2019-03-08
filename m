Received: from eggs.gnu.org ([209.51.188.92]:40745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h29nJ-00071N-D2
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 02:19:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h29nI-0007lm-Bd
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 02:19:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48692)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1h29nI-0007l6-32
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 02:19:48 -0500
References: <1551695576-13205-1-git-send-email-thuth@redhat.com>
	<a0b53ff0-1ded-2a6e-aa4d-b1f4fcc407c1@redhat.com>
	<CAPyFy2AnxWBXjUOWRy7_YpoSFadQBAXRooM+t4g6t6XOaF1XgA@mail.gmail.com>
	<84cc4186-86a8-2152-11ab-bd4001b05ee7@redhat.com>
	<CAKBkRUyXQ=MucPiKWT7Q2Qt0jFiO_bszYxfsOjxHBNAFP_Hbsg@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <cc948981-1afc-926d-8715-a530500b3ad2@redhat.com>
Date: Fri, 8 Mar 2019 08:19:42 +0100
MIME-Version: 1.0
In-Reply-To: <CAKBkRUyXQ=MucPiKWT7Q2Qt0jFiO_bszYxfsOjxHBNAFP_Hbsg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] cirrus.yml: Add macOS continuous
 integration task
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li-Wen Hsu <lwhsu@freebsd.org>
Cc: Ed Maste <emaste@freebsd.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 07/03/2019 22.52, Li-Wen Hsu wrote:
> On Fri, Mar 8, 2019 at 4:30 AM Thomas Huth <thuth@redhat.com> wrote:
>>
>> On 07/03/2019 21.26, Ed Maste wrote:
>>> On Mon, 4 Mar 2019 at 07:11, Philippe Mathieu-Daud=C3=A9 <philmd@redh=
at.com> wrote:
>>>>
>>>> On 3/4/19 11:32 AM, Thomas Huth wrote:
>>>>> cirrus-ci.com also has the possibility to run CI tasks on macOS.
>>>>> Since most of the QEMU developers do not have access to macOS yet,
>>>>> let's add a CI pipeline for this operating system here, too.
>>>>
>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>> Acked-by: Ed Maste <emaste@freebsd.org>
>>
>> Thanks! I can take this patch through my qtest tree.
>=20
> Hi Thomas,
>=20
> Sorry for the late reply, I checked and tested the patch, it works
> fine.  BTW, may I suggest:
>=20
> From https://cirrus-ci.org/guide/macOS/ , the image high-sierra-base
> is lasted as "Not maintained", how about change to mojave-base?

Definitely! Not sure how I could have missed that... I was either blind,
or, how I remember it, the high-sierra-base image was not marked as
unmaintained yet and marked as the only image that had the brew system
pre-installed back then. Anyway, I've now switched to mojave-base and it
seems to work fine, too.

> Also, perhaps we can put the common:
>=20
> env:
>   CIRRUS_CLONE_DEPTH: 1
>=20
> in the global area?

Sure! I'll do that in v2.

 Thanks for the review,
  Thomas
