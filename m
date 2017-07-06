Received: from eggs.gnu.org ([2001:4830:134:3::10]:48119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dTEYi-00006l-Vg
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 17:43:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dTEYf-0003G1-Ti
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 17:43:37 -0400
Received: from mail-wr0-f175.google.com ([209.85.128.175]:34940)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dTEYf-0003F8-NY
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 17:43:33 -0400
Received: by mail-wr0-f175.google.com with SMTP id k67so20767186wrc.2
	for <qemu-devel@nongnu.org>; Thu, 06 Jul 2017 14:43:33 -0700 (PDT)
References: <20170607063555.7374-1-marcandre.lureau@redhat.com>
	<5c87e2bf-898e-221d-2b96-31147dd85c8a@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <06dedbe8-6c14-757f-a26e-42be4092e54b@redhat.com>
Date: Thu, 6 Jul 2017 23:43:27 +0200
MIME-Version: 1.0
In-Reply-To: <5c87e2bf-898e-221d-2b96-31147dd85c8a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] iscsi: use scsi_create_task()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:iSCSI" <qemu-block@nongnu.org>, Peter Lieven <pl@kamp.de>, Max Reitz <mreitz@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>

On 06/07/2017 23:37, John Snow wrote:
> 
> On 06/07/2017 02:35 AM, Marc-André Lureau wrote:
>> The function does the same initialization, and matches with
>> scsi_free_scsi_task() usage, and qemu doesn't need to know the
>> allocator details.
>>
> 
> Happy month-iversary for this patch!
> 
> Yeah, uh, we should probably not be reaching into this structure
> ourselves, huh? I had to look up the iscsi source just to confirm that
> we /were/ doing the right thing, but now we won't have to worry about it.
> 
>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Reviewed-by: John Snow <jsnow@redhat.com>
> 
> This should be care of... Ronnie, Paolo, and Peter Lieven?

The only snag:

commit 0c6e3bffb353f141bb68fe822e3ea9df5eee8c8c
Author: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Date:   Thu Dec 18 09:20:17 2014 -0800

    SCSI: scsi_create_task must set task->cdb_size
    
    We forgot to set task->cdb_size which means all tasks we create with this
    function becomes test unit ready :-(
    
    Signed-off-by: Ronnie Sahlberg <ronniesahlberg@gmail.com>


At least RHEL7 has libiscsi-1.9.0.

Paolo
