Received: from eggs.gnu.org ([209.51.188.92]:58361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ggX87-0003p0-9D
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 10:47:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ggX86-0002Gg-Dw
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 10:47:55 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190102140535.11512-1-cfergeau@redhat.com>
	<20190102180158.GA6015@natto.ory.fergeau.eu>
	<4ff5eb04-e1e0-7126-c08d-58d1f28b4f27@redhat.com>
Date: Mon, 07 Jan 2019 16:47:44 +0100
In-Reply-To: <4ff5eb04-e1e0-7126-c08d-58d1f28b4f27@redhat.com> (Eric Blake's
	message of "Wed, 2 Jan 2019 16:08:10 -0600")
Message-ID: <87o98sii5b.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] json: Fix % handling when not interpolating
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Christophe Fergeau <cfergeau@redhat.com>, qemu-devel@nongnu.org, qemu-stable@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> On 1/2/19 12:01 PM, Christophe Fergeau wrote:
>> Adding Markus to cc: list, I forgot to do it when sending the patch.
>
> Also worth backporting via qemu-stable, now in cc.
>
>> 
>> Christophe
>> 
>> On Wed, Jan 02, 2019 at 03:05:35PM +0100, Christophe Fergeau wrote:
>>> commit 8bca4613 added support for %% in json strings when interpolating,
>>> but in doing so, this broke handling of % when not interpolating as the
>>> '%' is skipped in both cases.
>>> This commit ensures we only try to handle %% when interpolating.

Impact?

If you're unable to assess, could you give us at least a reproducer?

>>> Signed-off-by: Christophe Fergeau <cfergeau@redhat.com>
>>> ---
>>>  qobject/json-parser.c | 10 ++++++----
>>>  tests/check-qjson.c   |  5 +++++
>>>  2 files changed, 11 insertions(+), 4 deletions(-)
>>>
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Patch looks good to me, but I'd like us to improve the commit message.
