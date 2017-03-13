Received: from eggs.gnu.org ([2001:4830:134:3::10]:40220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cnSvq-0006ya-3N
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 12:34:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cnSvn-0001lr-0f
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 12:34:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42286)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cnSvm-0001lM-Rv
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 12:34:46 -0400
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B3B0F3304C4
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 16:34:46 +0000 (UTC)
Date: Mon, 13 Mar 2017 16:34:39 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170313163429.GK4799@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170313124434.1043-1-quintela@redhat.com>
	<20170313124434.1043-8-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170313124434.1043-8-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 07/16] migration: Create x-multifd-group
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com, dgilbert@redhat.com

On Mon, Mar 13, 2017 at 01:44:25PM +0100, Juan Quintela wrote:
> Indicates how many pages we are going to send in each bach to a multifd
> thread.


> diff --git a/qapi-schema.json b/qapi-schema.json
> index b7cb26d..33a6267 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -988,6 +988,9 @@
>  # @x-multifd-threads: Number of threads used to migrate data in parallel
>  #                     The default value is 2 (since 2.9)
>  #
> +# @x-multifd-group: Number of pages sent together to a thread
> +#                     The default value is 16 (since 2.9)
> +#
>  # Since: 2.4
>  ##
>  { 'enum': 'MigrationParameter',
> @@ -995,7 +998,7 @@
>             'cpu-throttle-initial', 'cpu-throttle-increment',
>             'tls-creds', 'tls-hostname', 'max-bandwidth',
>             'downtime-limit', 'x-checkpoint-delay',
> -           'x-multifd-threads'] }
> +           'x-multifd-threads', 'x-multifd-group'] }
>  
>  ##
>  # @migrate-set-parameters:
> @@ -1062,6 +1065,9 @@
>  # @x-multifd-threads: Number of threads used to migrate data in parallel
>  #                     The default value is 2 (since 2.9)
>  #
> +# @x-multifd-group: Number of pages sent together in a bunch
> +#                     The default value is 16 (since 2.9)
> +#

How is this parameter supposed to be used ? Or to put it another way,
what are the benefits / effects of changing it from its default
value and can an application usefully decide what value to set ? I'm
loathe to see us expose another "black magic" parameter where you can't
easily determine what values to set, without predicting future guest
workloads


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
