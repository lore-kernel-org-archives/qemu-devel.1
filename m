Received: from eggs.gnu.org ([2001:4830:134:3::10]:33530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d3Ki6-0007WM-5V
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 07:02:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d3Ki0-00069F-8Y
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 07:02:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:15134)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d3Ki0-00068l-2a
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 07:02:08 -0400
Date: Wed, 26 Apr 2017 12:02:02 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170426110202.GF18933@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1493161481-29595-1-git-send-email-mdroth@linux.vnet.ibm.com>
	<1493161481-29595-9-git-send-email-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1493161481-29595-9-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PULL 8/8] qga: Add `guest-get-timezone` command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, Vinzenz Feenstra <vfeenstr@redhat.com>

On Tue, Apr 25, 2017 at 06:04:41PM -0500, Michael Roth wrote:
> From: Vinzenz Feenstra <vfeenstr@redhat.com>
> 
> Adds a new command `guest-get-timezone` reporting the currently
> configured timezone on the system. The information on what timezone is
> currently is configured is useful in case of Windows VMs where the
> offset of the hardware clock is required to have the same offset. This
> can be used for management systems like `oVirt` to detect the timezone
> difference and warn administrators of the misconfiguration.

> +GuestTimezone *qmp_guest_get_timezone(Error **errp)
> +{

> +    name = g_time_zone_get_abbreviation(tz, intv);

[snip]

> +##
> +# @GuestTimezone:
> +#
> +# @zone:    Timezone name

This isn't clearly documented in glib, but it looks like the time zone
names are *different* when glib is run on POSIX vs Win32 platforms.

Do we really want to expose something in QAPI that is going to have
different semantics depending on the guest OS the agent runs in ?

> +# @offset:  Offset to UTC in seconds, negative numbers for time zones west of
> +#           GMT, positive numbers for east
> +#
> +# Since: 2.10
> +##
> +{ 'struct': 'GuestTimezone',
> +  'data':   { '*zone': 'str', 'offset': 'int' } }

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
