Received: from eggs.gnu.org ([2001:4830:134:3::10]:47674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cgcmU-000309-1I
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 14:40:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cgcmP-0007bd-6l
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 14:40:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cgcmO-0007b0-MN
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 14:40:48 -0500
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170222151729.5812-1-danielhb@linux.vnet.ibm.com> (Daniel
	Henrique Barboza's message of "Wed, 22 Feb 2017 12:17:29 -0300")
References: <20170222151729.5812-1-danielhb@linux.vnet.ibm.com>
Reply-To: quintela@redhat.com
Date: Wed, 22 Feb 2017 20:40:41 +0100
Message-ID: <877f4iko92.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3] Changing error message of QMP
 'migrate_set_downtime' to seconds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com

Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com> wrote:
> Using QMP, the error message of 'migrate_set_downtime' was displaying
> the values in milliseconds, being misleading with the command that
> accepts the value in seconds:
>
> { "execute": "migrate_set_downtime", "arguments": {"value": 3000}}
> {"error": {"class": "GenericError", "desc": "Parameter 'downtime_limit'
> expects an integer in the range of 0 to 2000000 milliseconds"}}
>
> This message is also seen in HMP when trying to set the same
> parameter:
>
> (qemu) migrate_set_parameter downtime-limit 3000000
> Parameter 'downtime_limit' expects an integer in the range of 0 to
> 2000000 milliseconds
>
> To allow for a proper error message when using QMP, a validation
> of the user input was added in 'qmp_migrate_set_downtime'.
>
> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

Queued.  Thanks.
