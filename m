Received: from eggs.gnu.org ([2001:4830:134:3::10]:52054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vadim.galitsyn@profitbricks.com>) id 1e6ePw-0004y8-AE
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 11:13:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vadim.galitsyn@profitbricks.com>) id 1e6ePs-00029q-4W
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 11:13:28 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:46712)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vadim.galitsyn@profitbricks.com>)
	id 1e6ePr-00029K-Ts
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 11:13:24 -0400
Received: by mail-wr0-x231.google.com with SMTP id l1so17769185wrc.3
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 08:13:23 -0700 (PDT)
From: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>
Date: Mon, 23 Oct 2017 17:13:06 +0200
Message-Id: <20171023151310.6462-1-vadim.galitsyn@profitbricks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] QMP, HMP: introduce 'writeconfig' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: vadim.galitsyn@profitbricks.com, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org

Hi Guys,

This thread is a continuation of discussion started in
http://lists.nongnu.org/archive/html/qemu-devel/2017-02/msg03182.html.

This series introduces ‘writeconfig’ command support for QMP and HMP monitors. This functionality might be useful for live migration for cases when guest configuration was modified in runtime (for example as a result of hot- plug/unplug operations) and actual Qemu command line no longer reflects setup exposed to guest.

Original series has ‘qemu_opts’ patch as well (http://lists.nongnu.org/archive/html/qemu-devel/2017-02/msg03183.html) because HMP’s ‘object_add’ result was not reflected in ‘writeconfig’ output. Later I found that QMP’s ‘object-add’ has the same issue. Anyway, I don’t include ‘qemu_opts’ patches here because Markus mentioned (here http://lists.nongnu.org/archive/html/qemu-devel/2017-02/msg03476.html) that this functionality is going to be reworked in some future and such patches might collide with the rework process.

Markus, could you please post if you have an update on this topic? Current ‘master’ branch (9993c82dc2f5ce58b41d708b765e1a717ad4281d) still has the issue.

Also, Markus mentioned that once configuration was changed during live migration -- it might be an issue because ‘writeconfig’ data became outdated (and might be make sense to think about to embed this data into migration stream itself). In the same time David said that this is another problem which is unrelated to this patch series. What is your current opinion on this topic? Can we consider these patches to be included into ‘master’ taking into account that not all configuration is dumped by ‘writeconfig’ (‘object_add’ problem), but this can be fixed later?

Best regards,
Vadim
