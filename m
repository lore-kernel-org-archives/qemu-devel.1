Received: from eggs.gnu.org ([2001:4830:134:3::10]:34765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gJtLR-0007zK-Mm
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 23:52:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gJtLO-00031E-Fx
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 23:52:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:41516 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1gJtLO-00030s-AH
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 23:52:02 -0500
References: <20181101101715.9443-1-fli@suse.com>
	<20181101101715.9443-8-fli@suse.com> <8736sfvd5m.fsf@trasno.org>
From: Fei Li <fli@suse.com>
Message-ID: <06ce487b-1887-4dc5-89f5-ce9a46fd50ea@suse.com>
Date: Tue, 6 Nov 2018 12:51:54 +0800
MIME-Version: 1.0
In-Reply-To: <8736sfvd5m.fsf@trasno.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH RFC v7 7/9] migration: remove unused
 &local_err parameter in migrate_set_error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com
Cc: peterx@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com, armbru@redhat.com



On 11/05/2018 09:59 PM, Juan Quintela wrote:
> Fei Li <fli@suse.com> wrote:
>> Always call migrate_set_error() to set the error state without relying
>> on whether multifd_save_cleanup() succeeds. As the passed &local_err
>> is never used in multifd_save_cleanup(), remove it.
> Error is not used, you are right.
>
> But then just change the prototype to:
>
> void multifd_save_cleanup(void);
>
> ??
>
> With that change,
>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
Thanks for the review!
Have changed that function to be void, besides, correct the previous 
erroneous
function name in the patch title:
s/migratr_set_error/multifd_save_cleanup/g.
