Received: from eggs.gnu.org ([2001:4830:134:3::10]:43645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dQ8u9-0004kv-D2
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 05:04:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dQ8u5-00037g-Cm
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 05:04:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48628)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dQ8u5-00037L-5e
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 05:04:53 -0400
Date: Wed, 28 Jun 2017 10:04:48 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170628090448.GE29134@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <cover.1498596157.git.alistair.francis@xilinx.com>
	<4e1eded5cda7b182a8a4cb133b40b2915817b7d1.1498596157.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4e1eded5cda7b182a8a4cb133b40b2915817b7d1.1498596157.git.alistair.francis@xilinx.com>
Subject: Re: [Qemu-devel] [RFC v1 2/3] util/qemu-error: Add a
 warning_report() function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, alistair23@gmail.com

On Tue, Jun 27, 2017 at 01:45:45PM -0700, Alistair Francis wrote:
> Add a functino which can be used similarly to error_report() execpt to
> inform the users about warnings instead of errors.
> 
> The warning print does not include the timestamp and instead will
> preface the messages with a 'warning: '.

Not including the timestamp is a bug IMHO. If I've turned on timestamps,
I expect all messages to have the timestamp.

I'm not particularly convinced by adding the 'warning: ' prefix either,
particularly given the scenario you are using this in, is not actually
a warning - its just a informative message.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
