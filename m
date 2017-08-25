Received: from eggs.gnu.org ([2001:4830:134:3::10]:35385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dlETA-0001G3-UY
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 09:16:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dlET7-0008Ml-O8
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 09:16:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54150)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dlET7-0008LA-HR
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 09:16:13 -0400
Date: Fri, 25 Aug 2017 10:16:10 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170825131610.GJ15315@localhost.localdomain>
References: <1503592308-93913-1-git-send-email-imammedo@redhat.com>
	<1503592308-93913-2-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1503592308-93913-2-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11 v3 01/25] qom: cpu: fix parsed
 feature string length
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>

On Thu, Aug 24, 2017 at 06:31:24PM +0200, Igor Mammedov wrote:
> since commit ( 9262685b cpu: Factor out cpu_generic_init() )
> features parsed by it were truncated only to the 1st feature
> after CPU name due to fact that
> 
>    featurestr = strtok(NULL, ",");
>    cc->parse_features(cpu, featurestr, &err);
> 
> would extract exactly one feature and parse_features() callback
> would parse it and only it leaving the rest of features ignored.
> 
> Reuse approach from x86 custom impl. i.e. replace strtok() token
> parsing with g_strsplit(), which would split feature string in
> 2 parts name and features list and pass the later to
> parse_features() callback.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
