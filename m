Received: from eggs.gnu.org ([2001:4830:134:3::10]:39207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fengguang.wu@intel.com>) id 1dvM5u-0008Nb-Rt
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 07:26:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fengguang.wu@intel.com>) id 1dvM5o-0006ro-As
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 07:26:06 -0400
Received: from mga06.intel.com ([134.134.136.31]:2552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fengguang.wu@intel.com>)
	id 1dvM5n-0006n6-Ki
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 07:26:00 -0400
Date: Fri, 22 Sep 2017 19:25:15 +0800
From: kbuild test robot <lkp@intel.com>
Message-ID: <201709221915.92rrS1kM%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170919115814.14724-3-marcandre.lureau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/4] fw_cfg: do DMA read operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcandre.lureau@redhat.com
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org, somlo@cmu.edu, qemu-devel@nongnu.org, mst@redhat.com


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Marc-André,

[auto build test WARNING on linus/master]
[also build test WARNING on v4.14-rc1 next-20170922]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/marcandre-lureau-redhat-com/fw_cfg-add-DMA-operations-etc-vmcoreinfo-support/20170922-182716
config: i386-randconfig-x000-201738 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   drivers//firmware/qemu_fw_cfg.c: In function 'fw_cfg_dma_transfer':
>> drivers//firmware/qemu_fw_cfg.c:139:18: warning: right shift count >= width of type [-Wshift-count-overflow]
     iowrite32be(dma >> 32, fw_cfg_reg_dma);
                     ^~
   In file included from include/uapi/linux/stddef.h:1:0,
                    from include/linux/stddef.h:4,
                    from include/uapi/linux/posix_types.h:4,
                    from include/uapi/linux/types.h:13,
                    from include/linux/types.h:5,
                    from include/linux/list.h:4,
                    from include/linux/module.h:9,
                    from drivers//firmware/qemu_fw_cfg.c:30:
   drivers//firmware/qemu_fw_cfg.c: At top level:
   include/linux/compiler.h:162:4: warning: '______f' is static but declared in inline function 'strcpy' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:154:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:421:2: note: in expansion of macro 'if'
     if (p_size == (size_t)-1 && q_size == (size_t)-1)
     ^~
   include/linux/compiler.h:162:4: warning: '______f' is static but declared in inline function 'kmemdup' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:154:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:411:2: note: in expansion of macro 'if'
     if (p_size < size)
     ^~
   include/linux/compiler.h:162:4: warning: '______f' is static but declared in inline function 'kmemdup' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:154:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:409:2: note: in expansion of macro 'if'
     if (__builtin_constant_p(size) && p_size < size)
     ^~
   include/linux/compiler.h:162:4: warning: '______f' is static but declared in inline function 'memchr_inv' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:154:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:400:2: note: in expansion of macro 'if'
     if (p_size < size)
     ^~
   include/linux/compiler.h:162:4: warning: '______f' is static but declared in inline function 'memchr_inv' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:154:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:398:2: note: in expansion of macro 'if'
     if (__builtin_constant_p(size) && p_size < size)
     ^~
   include/linux/compiler.h:162:4: warning: '______f' is static but declared in inline function 'memchr' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:154:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:389:2: note: in expansion of macro 'if'
     if (p_size < size)
     ^~
   include/linux/compiler.h:162:4: warning: '______f' is static but declared in inline function 'memchr' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:154:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:387:2: note: in expansion of macro 'if'
     if (__builtin_constant_p(size) && p_size < size)
     ^~
   include/linux/compiler.h:162:4: warning: '______f' is static but declared in inline function 'memcmp' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:154:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:379:2: note: in expansion of macro 'if'
     if (p_size < size || q_size < size)
     ^~
   include/linux/compiler.h:162:4: warning: '______f' is static but declared in inline function 'memcmp' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:154:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:376:3: note: in expansion of macro 'if'
      if (q_size < size)
      ^~
   include/linux/compiler.h:162:4: warning: '______f' is static but declared in inline function 'memcmp' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:154:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:374:3: note: in expansion of macro 'if'
      if (p_size < size)

vim +139 drivers//firmware/qemu_fw_cfg.c

   102	
   103	static ssize_t fw_cfg_dma_transfer(void *address, u32 length, u32 control)
   104	{
   105		dma_addr_t dma_addr = 0;
   106		struct fw_cfg_dma *d;
   107		dma_addr_t dma;
   108		ssize_t ret = length;
   109		enum dma_data_direction dir =
   110			(control & FW_CFG_DMA_CTL_READ ? DMA_FROM_DEVICE : 0);
   111	
   112		if (address && length) {
   113			dma_addr = dma_map_single(dev, address, length, dir);
   114			if (dma_mapping_error(NULL, dma_addr)) {
   115				WARN(1, "%s: failed to map address\n", __func__);
   116				return -EFAULT;
   117			}
   118		}
   119	
   120		d = kmalloc(sizeof(*d), GFP_KERNEL | GFP_DMA);
   121		if (!d) {
   122			ret = -ENOMEM;
   123			goto end;
   124		}
   125	
   126		dma = dma_map_single(dev, d, sizeof(*d), DMA_BIDIRECTIONAL);
   127		if (dma_mapping_error(NULL, dma)) {
   128			WARN(1, "%s: failed to map fw_cfg_dma\n", __func__);
   129			ret = -EFAULT;
   130			goto end;
   131		}
   132	
   133		*d = (struct fw_cfg_dma) {
   134			.address = cpu_to_be64(dma_addr),
   135			.length = cpu_to_be32(length),
   136			.control = cpu_to_be32(control)
   137		};
   138	
 > 139		iowrite32be(dma >> 32, fw_cfg_reg_dma);
   140		iowrite32be(dma, fw_cfg_reg_dma + 4);
   141		while (be32_to_cpu(d->control) & ~FW_CFG_DMA_CTL_ERROR)
   142			yield(); /* FIXME: wait_event? */
   143	
   144		if (be32_to_cpu(d->control) & FW_CFG_DMA_CTL_ERROR)
   145			ret = -EIO;
   146	
   147		dma_unmap_single(dev, dma, sizeof(*d), DMA_BIDIRECTIONAL);
   148	
   149	end:
   150		kfree(d);
   151		if (dma_addr)
   152			dma_unmap_single(dev, dma_addr, length, dir);
   153	
   154		return ret;
   155	}
   156	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--tKW2IUtsqtDRztdT
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
fKqFqBHMAQA=

--tKW2IUtsqtDRztdT--
