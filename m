Received: from eggs.gnu.org ([2001:4830:134:3::10]:35164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fRIvh-0003um-3Q
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 11:03:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fRIvc-0002oO-KU
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 11:03:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46070)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fRIvc-0002nv-FM
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 11:03:48 -0400
Date: Fri, 8 Jun 2018 12:03:42 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180608150342.GJ7451@localhost.localdomain>
References: <20180608143026.20167-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180608143026.20167-1-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] configure: Require Python 2.7 or newer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, "Daniel P. Berrange" <berrange@redhat.com>, Cleber Rosa <crosa@redhat.com>

On Fri, Jun 08, 2018 at 11:30:26AM -0300, Eduardo Habkost wrote:
> All of the supported build platforms documented in qemu-doc.texi
> should already support Python 2.7.
> 
> Removing support for Python 2.6 will allow us to remove some
> compatibility modules we carry in the QEMU tree:
> 
> * scripts/argparse.py
> * scripts/ordereddict.py
> 
> Python 2.6 is also not receiving bug fixes upstream and is not
> supported by pylint, which makes it harder to keep the code
> compatible with both Python 2 and Python 3.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

For reference, this is has info on the Python 2 version on many
popular software repositories:

https://repology.org/metapackage/python2/versions

I did this to check for repositories that don't have any 2.7 package:

  $ curl -s 'https://repology.org/api/v1/metapackage/python2' | \
    jq -r 'group_by(.repo) | .[] | "\(.[0].repo): \(map(.version))"' | \
    grep -v '"2\.7'
  centos_6: ["2.6.6"]
  maemo_fremantle: ["2.5.4","2.5.4","2.5.4","2.5.4"]
  rosa_server_6_9: ["2.6.6"]

-- 
Eduardo
