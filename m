Received: from eggs.gnu.org ([2001:4830:134:3::10]:43067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1gHWOk-00076u-VH
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 11:57:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1gHWOa-0000H1-O2
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 11:57:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43869)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1gHWOa-00005W-Cn
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 11:57:32 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ED7632027A
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 15:57:29 +0000 (UTC)
References: <20181030123526.26415-1-kchamart@redhat.com>
	<20181030130002.GO22057@paraplu>
From: Michal Privoznik <mprivozn@redhat.com>
Message-ID: <13acf644-bf86-9b56-8f51-a5a30bb6ee2b@redhat.com>
Date: Tue, 30 Oct 2018 16:56:40 +0100
MIME-Version: 1.0
In-Reply-To: <20181030130002.GO22057@paraplu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/3] Deprecate QMP & HMP `cpu-add`;
 document vCPU hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, ehabkost@redhat.com, libvir-list@redhat.com, armbru@redhat.com, imammedo@redhat.com

On 10/30/2018 02:00 PM, Kashyap Chamarthy wrote:
> [Cc: libvir-list]
> 
> On Tue, Oct 30, 2018 at 01:35:23PM +0100, Kashyap Chamarthy wrote:
>> The first patch deprecates the QMP `cpu-add`, the second its HMP 
>> equivalent, and the third documents vCPU hotplug procedure using QMP
>> `device_add` et al.

Thanks for heads up. Libvirt already uses device_add if
'query-hotpluggable-cpus' command is available and 'query-machines'
returns 'hotpluggable-cpus: yes' for given machine type. It only falls
back to cpu-add.

Michal
