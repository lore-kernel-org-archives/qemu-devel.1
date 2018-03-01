Received: from eggs.gnu.org ([2001:4830:134:3::10]:57021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1erNnB-0000Dm-0R
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 07:58:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1erNn7-0005I5-Va
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 07:58:37 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu,  1 Mar 2018 13:58:03 +0100
Message-Id: <20180301125830.24377-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL v2 00/27] s390x updates (and friends)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, rth@twiddle.net, agraf@suse.de, david@redhat.com, thuth@redhat.com, Cornelia Huck <cohuck@redhat.com>

The following changes since commit 0a773d55ac76c5aa89ed9187a3bc5af8c5c2a6d0:

  maintainers: Add myself as a OpenBSD maintainer (2018-02-23 12:05:07 +0000)

are available in the git repository at:

  git://github.com/cohuck/qemu tags/s390x-20180301-v2

for you to fetch changes up to be8b49de2491145a7aad3201803327b6f568cbd3:

  s390x/tcg: fix loading 31bit PSWs with the highest bit set (2018-03-01 13:23:09 +0100)

----------------------------------------------------------------
- add query-cpus-fast and deprecate query-cpus, while adding s390 cpu
  information
- remove s390x memory hotplug implementation, which is not useable in
  this form
- add boot menu support in the s390-ccw bios
- expose s390x guest crash information
- fixes and cleaups

----------------------------------------------------------------

Christian Borntraeger (1):
  s390x/cpu: expose the guest crash information

Collin L. Walling (13):
  s390-ccw: refactor boot map table code
  s390-ccw: refactor eckd_block_num to use CHS
  s390-ccw: refactor IPL structs
  s390-ccw: update libc
  s390-ccw: move auxiliary IPL data to separate location
  s390-ccw: parse and set boot menu options
  s390-ccw: set up interactive boot menu parameters
  s390-ccw: read stage2 boot loader data to find menu
  s390-ccw: print zipl boot menu
  s390-ccw: read user input for boot index via the SCLP console
  s390-ccw: set cp_receive mask only when needed and consume pending
    service irqs
  s390-ccw: use zipl values when no boot menu options are present
  s390-ccw: interactive boot menu for scsi

Cornelia Huck (1):
  s390x: remove s390_get_memslot_count

David Hildenbrand (4):
  s390x/tcg: fix disabling/enabling DAT
  s390x/tcg: add various alignment checks
  s390x/sclp: remove memory hotplug support
  s390x/tcg: fix loading 31bit PSWs with the highest bit set

Dr. David Alan Gilbert (1):
  s390/stattrib: Make SaveVMHandlers data static

Halil Pasic (1):
  s390x/cpumodel: document S390FeatDef.bit not applicable

Luiz Capitulino (1):
  qmp: add query-cpus-fast

Thomas Huth (1):
  pc-bios/s390: Rebuild the s390x firmware images with the boot menu
    changes

Viktor Mihajlovski (4):
  qmp: expose s390-specific CPU info
  qmp: add architecture specific cpu data for query-cpus-fast
  qemu-doc: deprecate query-cpus
  hmp: change hmp_info_cpus to use query-cpus-fast

-- 
2.13.6
