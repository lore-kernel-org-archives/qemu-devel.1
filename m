Received: from eggs.gnu.org ([2001:4830:134:3::10]:40414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eNiH0-0003un-Fq
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 11:46:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eNiGx-0005cz-CW
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 11:46:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eNiGx-0005cb-6V
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 11:46:43 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 59A8B36809
	for <qemu-devel@nongnu.org>; Sat,  9 Dec 2017 16:46:41 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20171016191141.GK2252@work-vm> (David Alan Gilbert's message of
	"Mon, 16 Oct 2017 20:11:41 +0100")
References: <20171004104636.7963-1-quintela@redhat.com>
	<20171004104636.7963-5-quintela@redhat.com>
	<20171016191141.GK2252@work-vm>
Reply-To: quintela@redhat.com
Date: Sat, 09 Dec 2017 17:46:36 +0100
Message-ID: <87efo3rgr7.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v9 04/12] migration: Start of multiple fd
 work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:

>> +static void multifd_new_channel_async(QIOTask *task, gpointer opaque)
>> +{
>> +    MultiFDSendParams *p = opaque;
>> +    QIOChannel *sioc = QIO_CHANNEL(qio_task_get_source(task));
>> +    Error *local_err;
>
> Does that need an = NULL ?


Good catch.  Fixed.

>> +    if (errp) {
>> +        MigrationState *s = migrate_get_current();
>> +        migrate_set_error(s, errp);
>> +        migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
>> +                          MIGRATION_STATUS_FAILED);
>
> Are we necessarily in ACTIVE at this point?   I suspect there
> are some SETUP and I wonder if there are others.

We only care about SETUP & ACTIVE.  We could still be on SETUP here as
far as I can see.  Fixed for both send and recv size.

Later, Juan.
