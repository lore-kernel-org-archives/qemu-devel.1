Received: from eggs.gnu.org ([2001:4830:134:3::10]:44833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1coRT2-0001ib-C5
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:13:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1coRSz-00042Q-8P
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:13:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51736)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1coRSz-000429-2C
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:13:05 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 096D1C208063
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 09:13:05 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170315161603.30135-1-berrange@redhat.com>
	<20170315164445.GA2701@work-vm>
Date: Thu, 16 Mar 2017 10:13:02 +0100
In-Reply-To: <20170315164445.GA2701@work-vm> (David Alan Gilbert's message of
	"Wed, 15 Mar 2017 16:44:46 +0000")
Message-ID: <87lgs5k2jl.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for 2.9] migration: use "" as the default
 for tls-creds/hostname
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:

> * Daniel P. Berrange (berrange@redhat.com) wrote:
>> The tls-creds parameter has a default value of NULL indicating
>> that TLS should not be used. Setting it to non-NULL enables
>> use of TLS. Once tls-creds are set to a non-NULL value via the
>> monitor, it isn't possible to set them back to NULL again, due
>> to current implementation limitations. The empty string is not
>> a valid QObject identifier, so this switches to use "" as the
>> default, indicating that TLS will not be used
>> 
>> The tls-hostname parameter has a default value of NULL indicating
>> the the hostname from the migrate connection URI should be used.
>> Again, once tls-hostname is set non-NULL, to override the default
>> hostname for x509 cert validation, it isn't possible to reset it
>> back to NULL via the monitor. The empty string is not a valid
>> hostname, so this switches to use "" as the default, indicating
>> that the migrate URI hostname should be used.
>> 
>> Using "" as the default for both, also means that the monitor
>> commands "info migrate_parameters" / "query-migrate-parameters"
>> will report existance of tls-creds/tls-parameters even when set
>> to their default values.
>> 
>> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
>
> Yes, simple enough.
>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>
> Markus, Eric - are you OK with that?

No objections.
