Received: from eggs.gnu.org ([2001:4830:134:3::10]:49776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUZvo-0002HY-Iu
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 11:21:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUZvj-0004PB-LW
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 11:21:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34736)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gUZvj-0004OQ-FE
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 11:21:43 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <154393964026.28192.13536237934563059985.stgit@gimli.home>
	<154394077749.28192.1229512133780284321.stgit@gimli.home>
	<83c490a2-7565-b95c-563f-fb73476e874f@redhat.com>
	<87d0qgrrd0.fsf@dusky.pond.sub.org>
	<3821b727-a0ec-5f92-4ec9-f858322457bc@redhat.com>
Date: Wed, 05 Dec 2018 17:21:41 +0100
In-Reply-To: <3821b727-a0ec-5f92-4ec9-f858322457bc@redhat.com> (Auger Eric's
	message of "Wed, 5 Dec 2018 15:27:17 +0100")
Message-ID: <87pnugq6zu.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [for-4.0 PATCH v3 3/9] qapi: Define PCIe link
 speed and width properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: Geoffrey McRae <geoff@hostfission.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org

Auger Eric <eric.auger@redhat.com> writes:

> Hi Markus,
>
> On 12/5/18 3:16 PM, Markus Armbruster wrote:
>> Auger Eric <eric.auger@redhat.com> writes:
[...]
>>> nit: g_assert_not_reached() here and below.
>> 
>> In my opinion, g_assert_not_reached() & friends are an overly ornate
>> reinvention of an old and perfectly adequate wheel.
>> 
>> A long time ago for reasons since forgotten, the maintainers in charge
>> back then demanded abort() instead of assert(0).  Either is fine with
>> me.
>> 
>> I tolerate g_assert_not_reached() in files that already use g_assert().
>> This one doesn't.
>> 
>> In any case, I'd drop the comment.
>
> OK I did not know. In the past I was encouraged to use it.

Some maintainers like ornate ;)

> Thanks
>
> Eric
>> 
>> Note that I'm not this file's maintainer.
>> 
>> [...]
