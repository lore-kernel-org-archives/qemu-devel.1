Received: from eggs.gnu.org ([208.118.235.92]:36881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ehLm3-0003ng-JT
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 15:52:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ehLky-0001ja-UM
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 15:47:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52484)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ehLky-0001hY-F3
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 15:46:52 -0500
Date: Thu, 1 Feb 2018 18:46:46 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180201204646.GK21702@localhost.localdomain>
References: <20180116134217.8725-1-berrange@redhat.com>
	<20180116134217.8725-12-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180116134217.8725-12-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 11/14] input: add missing JIS keys to
 virtio input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Miika S <miika9764@gmail.com>, Fam Zheng <famz@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

On Tue, Jan 16, 2018 at 01:42:14PM +0000, Daniel P. Berrange wrote:
> From: Miika S <miika9764@gmail.com>
> 
> keycodemapdb updated to add the QKeyCodes muhenkan and katakanahiragana
> 
> Signed-off-by: Miika S <miika9764@gmail.com>

Oops, this conflicts with:

commit ae6b06ab655b21c19b234ce3422f694d11a013e0
Author: Daniel P. Berrange <berrange@redhat.com>
Date:   Wed Jan 17 16:41:18 2018 +0000

    hw: convert virtio-input-hid device to keycodemapdb
    
    [...]

Patch 11/14 and 12/14 need to be redone.  I'm removing patches
11-14 from python-next until this is sorted out.

-- 
Eduardo
