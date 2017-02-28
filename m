Received: from eggs.gnu.org ([2001:4830:134:3::10]:41538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cihCG-0006ay-OO
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:48:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cihCD-0002B9-O8
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:48:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cihCD-0002At-Gp
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:48:01 -0500
Date: Tue, 28 Feb 2017 20:47:57 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170228124757.GC29328@lemon.lan>
References: <20170228122901.24520-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170228122901.24520-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] Fix stale 'trace-events-all' file in
 build dir
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Tue, 02/28 12:28, Daniel P. Berrange wrote:
> If systemtap support was disabled, the trace-events-all file was
> only getting regenerated at time of 'make instal'. This is bad
> because it leaves stale files in the build dir for developers.

Apparently 6eab3544f472 wasn't a good job. :-/

For both patches:

Reviewed-by: Fam Zheng <famz@redhat.com>
