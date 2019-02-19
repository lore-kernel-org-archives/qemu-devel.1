Received: from eggs.gnu.org ([209.51.188.92]:44461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gvyD6-000743-Tv
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 00:44:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gvyD2-0002Md-Fj
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 00:44:51 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190218125615.18970-1-armbru@redhat.com>
	<20190218125615.18970-10-armbru@redhat.com>
	<24f3ced9-10cd-0ceb-0ed7-1e10a7803eca@redhat.com>
	<0ad81584-4081-5c12-f4de-d4eaf0479416@redhat.com>
Date: Tue, 19 Feb 2019 06:44:16 +0100
In-Reply-To: <0ad81584-4081-5c12-f4de-d4eaf0479416@redhat.com> (Laszlo Ersek's
	message of "Mon, 18 Feb 2019 18:56:56 +0100")
Message-ID: <87imxgz61b.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 09/10] pflash: Clean up after commit
 368a354f02b part 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-ppc@nongnu.org, alex.bennee@linaro.org, qemu-block@nongnu.org, mreitz@redhat.com

Laszlo Ersek <lersek@redhat.com> writes:

> On 02/18/19 18:01, Laszlo Ersek wrote:
>> On 02/18/19 13:56, Markus Armbruster wrote:
>>> QOMification left parameter @size unused in pflash_cfi01_register()
>>> and pflash_cfi02_register().  register().  Obviously, @size should
>
> I meant to point out the typo above, but I got distracted mid-review. Sorry!

Will fix, thanks!
