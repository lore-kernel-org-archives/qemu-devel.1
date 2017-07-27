Received: from eggs.gnu.org ([2001:4830:134:3::10]:60467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <asegundo@redhat.com>) id 1dakGa-00005j-7W
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:59:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <asegundo@redhat.com>) id 1dakGX-0001ky-5h
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:59:56 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:38319)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <asegundo@redhat.com>) id 1dakGX-0001kf-1F
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:59:53 -0400
Received: by mail-it0-f54.google.com with SMTP id h199so83730817ith.1
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 07:59:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170727141804.GJ10129@stefanha-x1.localdomain>
References: <20170725171014.25193-1-apahim@redhat.com>
	<20170725171014.25193-2-apahim@redhat.com>
	<20170727141804.GJ10129@stefanha-x1.localdomain>
From: Amador Pahim <apahim@redhat.com>
Date: Thu, 27 Jul 2017 16:59:51 +0200
Message-ID: <CALAZnb2gbNjkkTcW0nEbS-=vLktK492JLZQbk-nL+C2uKV3x1A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 1/6] qemu.py: make 'args' public
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Daniel Berrange <berrange@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>

On Thu, Jul 27, 2017 at 4:18 PM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Tue, Jul 25, 2017 at 07:10:09PM +0200, Amador Pahim wrote:
>> Let's make args public so users can extend it in instances
>> without feeling like abusing the internal API.
>>
>> Signed-off-by: Amador Pahim <apahim@redhat.com>
>> ---
>>  scripts/qemu.py               | 14 +++++++-------
>>  tests/qemu-iotests/iotests.py | 18 +++++++++---------
>>  2 files changed, 16 insertions(+), 16 deletions(-)
>
> As discussed in the previous revision, I don't think this patch is
> justified because all current users just need a protected field.  There
> are no users who need the field to be public so this change is
> premature.

Indeed. It will be removed from the next version.

>
> Stefan
