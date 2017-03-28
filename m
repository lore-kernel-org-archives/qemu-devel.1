Received: from eggs.gnu.org ([2001:4830:134:3::10]:55757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1csmHD-0001xg-Rc
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:14:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1csmHB-0001Uh-7z
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:14:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41842)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1csmHB-0001UO-1j
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:14:49 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E0E60C04B920
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 08:14:47 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1490621195-2228-1-git-send-email-armbru@redhat.com>
	<1490621195-2228-4-git-send-email-armbru@redhat.com>
	<20170328021224.GK15423@localhost.localdomain>
Date: Tue, 28 Mar 2017 10:14:46 +0200
In-Reply-To: <20170328021224.GK15423@localhost.localdomain> (Jeff Cody's
	message of "Mon, 27 Mar 2017 22:12:24 -0400")
Message-ID: <87bmsl4y2x.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC v3 for-2.9 03/11] rbd: Don't limit
 length of parameter values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: kwolf@redhat.com, jdurgin@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

Jeff Cody <jcody@redhat.com> writes:

> On Mon, Mar 27, 2017 at 03:26:27PM +0200, Markus Armbruster wrote:
>> We laboriously enforce parameter values are between one and some
>
> s/are/that are/
>
> or maybe just s/are//

What about:

   We laboriously enforce that parameter values are between one and some

>> arbitrary limit in length.  Only RBD_MAX_IMAGE_NAME_SIZE comes from
>> librbd.h, and I'm not sure it applies.  Where the other limits come
>> from is unclear.
>> 
>> Drop the length checking.  The limits librbd actually imposes must be
>> checked by librbd anyway.
>> 
>> There's one minor complication: BDRVRBDState member name is a
>> fixed-size array.  Depends on the length limit.  Make it a pointer to
>> a dynamically allocated string.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>
> Reviewed-by: Jeff Cody <jcody@redhat.com>

Thanks!
