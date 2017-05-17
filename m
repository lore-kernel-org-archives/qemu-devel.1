Received: from eggs.gnu.org ([2001:4830:134:3::10]:39649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dB13z-0002Tg-UA
	for qemu-devel@nongnu.org; Wed, 17 May 2017 11:40:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dB13v-0005m4-Bq
	for qemu-devel@nongnu.org; Wed, 17 May 2017 11:40:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:5168)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dB13v-0005ll-5K
	for qemu-devel@nongnu.org; Wed, 17 May 2017 11:40:31 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0638181129
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 15:40:30 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170516161907.GM19824@localhost.localdomain> (Jeff Cody's
	message of "Tue, 16 May 2017 12:19:07 -0400")
References: <20170515140529.23264-1-dgilbert@redhat.com>
	<20170516161907.GM19824@localhost.localdomain>
Reply-To: quintela@redhat.com
Date: Wed, 17 May 2017 17:40:26 +0200
Message-ID: <87shk3bifp.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2] block migration: Allow compile time
 disable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, kashyap@redhat.com, eblake@redhat.com, kwolf@redhat.com

Jeff Cody <jcody@redhat.com> wrote:
> On Mon, May 15, 2017 at 03:05:29PM +0100, Dr. David Alan Gilbert (git) wrote:
>> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>> 
>> Many users now prefer to use drive_mirror over NBD as an
>> alternative to the older migrate -b option; drive_mirror is
>> more complex to setup but gives you more options (e.g. only
>> migrating some of the disks if some of them are shared).
>> 
>> Allow the large chunk of block migration code to be compiled
>> out for those who don't use it.
>> 
>> Based on a downstream-patch we've had for a while by Jeff Cody.
>> 
>> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>
> Reviewed-by: Jeff Cody <jcody@redhat.com>

Hi

You thought it was going to be so easy O:-)

You can see that this patch is the last one of the Series:

Remove old MigrationParams

And as there has been quite a bit of changes, I would preffer the
review-by there.  (Hint, hint)

Thanks, Juan.
