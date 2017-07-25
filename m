Received: from eggs.gnu.org ([2001:4830:134:3::10]:36229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <asegundo@redhat.com>) id 1da11t-0001fy-69
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:41:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <asegundo@redhat.com>) id 1da11o-0000nT-ST
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:41:45 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:33905)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <asegundo@redhat.com>) id 1da11o-0000mb-OW
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:41:40 -0400
Received: by mail-io0-f172.google.com with SMTP id l7so56806909iof.1
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 07:41:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170725133708.GE23343@stefanha-x1.localdomain>
References: <20170724124438.27344-1-apahim@redhat.com>
	<20170724124438.27344-2-apahim@redhat.com>
	<20170725133708.GE23343@stefanha-x1.localdomain>
From: Amador Pahim <apahim@redhat.com>
Date: Tue, 25 Jul 2017 16:41:37 +0200
Message-ID: <CALAZnb3TcQUyz2vyHZzRj6VK9-eRcjx=rxQTNjpzDuA4+24Gfg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 1/2] qemu.py: make 'args' public
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>, Fam Zheng <famz@redhat.com>

On Tue, Jul 25, 2017 at 3:37 PM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Mon, Jul 24, 2017 at 02:44:37PM +0200, Amador Pahim wrote:
>> Let's make args public so users can extend it without feeling like
>> abusing the internal API.
>
> Nothing is abusing an internal API.  PEP8 describes the difference
> between public (no underscore), protected aka subclass API (single
> underscore), and private fields (single or double underscore):
>
>   https://www.python.org/dev/peps/pep-0008/
>
> _args is a protected field.  It is perfectly normal for a subclass to
> access a protected field in its parent class.

Precisely. Idea is to make it public according to the concept of
public x protected from that very documentation ("Public attributes
are those that you expect unrelated clients of your class to use").
This makes sense for the work I'm doing on creating
functional/regression tests for qemu using Avocado Framework (patchs
to come), where we instantiate a QEMUMachine object to be offered
inside the Test API.

>
>> Signed-off-by: Amador Pahim <apahim@redhat.com>
>> Reviewed-by: Fam Zheng <famz@redhat.com>
>> ---
>>  scripts/qemu.py               | 10 +++++-----
>>  tests/qemu-iotests/iotests.py | 18 +++++++++---------
>>  2 files changed, 14 insertions(+), 14 deletions(-)
>
> Please don't do this, it encourages code duplication.  Now arbitrary
> users can start accessing the public field directly instead of adding a
> reusable interfaces like add_monitor_telnet(), add_fd(), etc.

Reusable interfaces can be quite complex to implement when all you
need is to add some options to the qemu command line. I'd not require
that from arbitrary users. Anyway, dropping this commit. Thanks for
the review.
