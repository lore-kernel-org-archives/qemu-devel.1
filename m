Received: from eggs.gnu.org ([2001:4830:134:3::10]:54517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1coQIB-0002Zv-BQ
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 03:57:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1coQI8-0000Le-3S
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 03:57:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52566)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1coQI7-0000LY-Tx
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 03:57:48 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DAAA680F99
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 07:57:47 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170315161603.30135-1-berrange@redhat.com> (Daniel
	P. Berrange's message of "Wed, 15 Mar 2017 16:16:03 +0000")
References: <20170315161603.30135-1-berrange@redhat.com>
Reply-To: quintela@redhat.com
Date: Thu, 16 Mar 2017 08:57:45 +0100
Message-ID: <87r31xy7pi.fsf@secure.mitica>
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

"Daniel P. Berrange" <berrange@redhat.com> wrote:
> The tls-creds parameter has a default value of NULL indicating
> that TLS should not be used. Setting it to non-NULL enables
> use of TLS. Once tls-creds are set to a non-NULL value via the
> monitor, it isn't possible to set them back to NULL again, due
> to current implementation limitations. The empty string is not
> a valid QObject identifier, so this switches to use "" as the
> default, indicating that TLS will not be used
>
> The tls-hostname parameter has a default value of NULL indicating
> the the hostname from the migrate connection URI should be used.
> Again, once tls-hostname is set non-NULL, to override the default
> hostname for x509 cert validation, it isn't possible to reset it
> back to NULL via the monitor. The empty string is not a valid
> hostname, so this switches to use "" as the default, indicating
> that the migrate URI hostname should be used.
>
> Using "" as the default for both, also means that the monitor
> commands "info migrate_parameters" / "query-migrate-parameters"
> will report existance of tls-creds/tls-parameters even when set
> to their default values.
>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

queued
