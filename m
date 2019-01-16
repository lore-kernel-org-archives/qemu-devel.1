Received: from eggs.gnu.org ([209.51.188.92]:48807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gjb0y-0002ZC-9r
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 21:33:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gjau5-0007UH-On
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 21:26:06 -0500
Date: Wed, 16 Jan 2019 10:25:45 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190116022544.GA13130@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <1888836717.9067.1547583207433.ref@mail.yahoo.com>
	<1888836717.9067.1547583207433@mail.yahoo.com>
	<20190116011233.GA10810@richard>
	<20190116021804.GA73677@tiger-server>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190116021804.GA73677@tiger-server>
Subject: Re: [Qemu-devel] Devdax backend for vnvdimm not working
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>, Kamal Kakri <kamalkakri2017@yahoo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-discuss@nongnu.org" <qemu-discuss@nongnu.org>

On Wed, Jan 16, 2019 at 10:18:05AM +0800, Yi Zhang wrote:
>On 2019-01-16 at 09:12:33 +0800, Wei Yang wrote:
>> On Tue, Jan 15, 2019 at 08:13:27PM +0000, Kamal Kakri via Qemu-devel wrote:
>> >Hi,
>> >
>> >I have a namespace (backed by real nvdimm h/w) configured in devdax mode:
>> ># ndctl list -N -n namespace0.0
>> >[
>> >  {
>> >    "dev":"namespace0.0",
>> >    "mode":"devdax",
>> >    "map":"dev",
>> >    "size":16909336576,
>> >    "uuid":"e5265c0a-d902-41ce-b1d1-87a78c358aa4",
>> >    "chardev":"dax0.0"
>> >  }
>> >]
>> >
>> 
>> Above is your host configuration, right?
>> 
>> >
>> >When I try to configure my vm using "virsh" with something like this:
>> >    <memory model='nvdimm' access='shared'>
>> >      <source>
>> >        <path>/dev/dax0.0</path>
>> >        <align unit='KiB'>2048</align>
>so that will apply the align=2048K for memory-backend-file?
>> >        <pmem/>
>> >      </source>
>> >      <target>
>> >        <size unit='KiB'>2097152</size>
>> >        <node>0</node>
>> >      </target>
>> >      <alias name='nvdimm0'/>
>> >      <address type='dimm' slot='0'/>
>> >    </memory>
>> >
>> 
>> I am not familiar with virsh, while I guess align here is the parameter passed
>> to qemu.
>> 
>> Hmm...  as I being told, the alignment should be 128M.
>2MB align is OK for this case.

Ok, so would you mind putting more word on the alignment?

Which case requires 128M and which requires 2M?

I got lost here.

-- 
Wei Yang
Help you, Help me
