Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4097EC388F9
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 13:10:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D7472224E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 13:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GyOWv5qF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D7472224E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZw5H-0005qK-D1
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 08:10:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kZw2A-00042e-45
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 08:07:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46981)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kZw27-00008Y-3O
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 08:07:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604408850;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=YokyWNy7IFwJCsUYdZKKSEZgZ2hTxOyy4g++ADxXIr8=;
 b=GyOWv5qFU5swWdbgpB+Am6DTQgIOm/bGyJiYcrKBj4I5iBXJJg7uyJPv38m3udS+t0WW8P
 WTEOpf/ZqlQ69ZeXkcN74wXG15rtyRi0Za1yK9S6LgF5/ce03HcaLWwdF4IbkCUyn+yEHu
 Vhza6P1VtNdjJtXU48orcQHyi20FZyc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-4DHCysivPo-QVgFcEjHz3w-1; Tue, 03 Nov 2020 08:07:23 -0500
X-MC-Unique: 4DHCysivPo-QVgFcEjHz3w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C756AF9AD;
 Tue,  3 Nov 2020 13:07:22 +0000 (UTC)
Received: from redhat.com (ovpn-115-87.ams2.redhat.com [10.36.115.87])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C4B8955763;
 Tue,  3 Nov 2020 13:07:19 +0000 (UTC)
Date: Tue, 3 Nov 2020 13:07:16 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Andrew Melnychenko <andrew@daynix.com>
Subject: Re: [RFC PATCH 3/6] ebpf: Added eBPF RSS program.
Message-ID: <20201103130716.GK205187@redhat.com>
References: <20201102185115.7425-1-andrew@daynix.com>
 <20201102185115.7425-4-andrew@daynix.com>
MIME-Version: 1.0
In-Reply-To: <20201102185115.7425-4-andrew@daynix.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: yan@daynix.com, yuri.benditovich@daynix.com, jasowang@redhat.com,
 qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 02, 2020 at 08:51:13PM +0200, Andrew Melnychenko wrote:
> From: Andrew <andrew@daynix.com>
> 
> RSS program and Makefile to build it.
> Also, added a python script that would generate '.h' file.
> The data in that file may be loaded by eBPF API.
> EBPF compilation is not required for building qemu.
> You can use Makefile if you need to regenerate tun_rss_steering.h.
> 
> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> ---
>  ebpf/EbpfElf_to_C.py    |  67 +++++
>  ebpf/Makefile.ebpf      |  38 +++
>  ebpf/rss.bpf.c          | 470 +++++++++++++++++++++++++++++++++
>  ebpf/tun_rss_steering.h | 556 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 1131 insertions(+)
>  create mode 100644 ebpf/EbpfElf_to_C.py
>  create mode 100755 ebpf/Makefile.ebpf
>  create mode 100644 ebpf/rss.bpf.c
>  create mode 100644 ebpf/tun_rss_steering.h
> 


> diff --git a/ebpf/Makefile.ebpf b/ebpf/Makefile.ebpf
> new file mode 100755
> index 0000000000..f7008d7d32
> --- /dev/null
> +++ b/ebpf/Makefile.ebpf
> @@ -0,0 +1,38 @@
> +OBJS = rss.bpf.o
> +
> +LLC ?= llc
> +CLANG ?= clang
> +INC_FLAGS = -nostdinc -isystem `$(CLANG) -print-file-name=include`
> +EXTRA_CFLAGS ?= -O2 -emit-llvm
> +
> +linuxhdrs = ~/src/kernel/master
> +
> +LINUXINCLUDE =  -I $(linuxhdrs)/arch/x86/include/uapi \
> +                -I $(linuxhdrs)/arch/x86/include/generated/uapi \
> +                -I $(linuxhdrs)/arch/x86/include/generated \
> +                -I $(linuxhdrs)/include/generated/uapi \
> +                -I $(linuxhdrs)/include/uapi \
> +                -I $(linuxhdrs)/include \
> +                -I $(linuxhdrs)/tools/lib
> +
> +all: $(OBJS)
> +
> +.PHONY: clean
> +
> +clean:
> +	rm -f $(OBJS)
> +
> +INC_FLAGS = -nostdinc -isystem `$(CLANG) -print-file-name=include`
> +
> +$(OBJS):  %.o:%.c
> +	$(CLANG) $(INC_FLAGS) \
> +                -D__KERNEL__ -D__ASM_SYSREG_H \
> +                -Wno-unused-value -Wno-pointer-sign \
> +                -Wno-compare-distinct-pointer-types \
> +                -Wno-gnu-variable-sized-type-not-at-end \
> +                -Wno-address-of-packed-member -Wno-tautological-compare \
> +                -Wno-unknown-warning-option \
> +                -I../include $(LINUXINCLUDE) \
> +                $(EXTRA_CFLAGS) -c $< -o -| $(LLC) -march=bpf -filetype=obj -o $@
> +	python3 EbpfElf_to_C.py -f rss.bpf.o -s tun_rss_steering

Note that QEMU has switched to Meson for its build system, so even if
we're not running the rules by default, they should still be defined
with Meson, rather than make.

> diff --git a/ebpf/rss.bpf.c b/ebpf/rss.bpf.c
> new file mode 100644
> index 0000000000..084fc33f96
> --- /dev/null
> +++ b/ebpf/rss.bpf.c
> @@ -0,0 +1,470 @@

Missing license header

> +#include <stddef.h>
> +#include <stdbool.h>
> +#include <linux/bpf.h>
> +
> +#include <linux/in.h>
> +#include <linux/if_ether.h>
> +#include <linux/ip.h>
> +#include <linux/ipv6.h>
> +
> +#include <linux/udp.h>
> +#include <linux/tcp.h>
> +
> +#include <bpf/bpf_helpers.h>
> +#include <linux/virtio_net.h>
> +
> +/*
> + * Prepare:
> + * Requires llvm, clang, python3 with pyelftools, linux kernel tree
> + *
> + * Build tun_rss_steering.h:
> + * make -f Mefile.ebpf clean all
> + */
> +
> +#define INDIRECTION_TABLE_SIZE 128
> +#define HASH_CALCULATION_BUFFER_SIZE 36
> +
> +struct rss_config_t {
> +    __u8 redirect;
> +    __u8 populate_hash;
> +    __u32 hash_types;
> +    __u16 indirections_len;
> +    __u16 default_queue;
> +};
> +
> +struct toeplitz_key_data_t {
> +    __u32 leftmost_32_bits;
> +    __u8 next_byte[HASH_CALCULATION_BUFFER_SIZE];
> +};
> +
> +struct packet_hash_info_t {
> +    __u8 is_ipv4;
> +    __u8 is_ipv6;
> +    __u8 is_udp;
> +    __u8 is_tcp;
> +    __u8 is_ipv6_ext_src;
> +    __u8 is_ipv6_ext_dst;
> +
> +    __u16 src_port;
> +    __u16 dst_port;
> +
> +    union {
> +        struct {
> +            __be32 in_src;
> +            __be32 in_dst;
> +        };
> +
> +        struct {
> +            struct in6_addr in6_src;
> +            struct in6_addr in6_dst;
> +            struct in6_addr in6_ext_src;
> +            struct in6_addr in6_ext_dst;
> +        };
> +    };
> +};
> +
> +struct {
> +    __uint(type, BPF_MAP_TYPE_ARRAY);
> +    __type(key, __u32);
> +    __type(value, struct rss_config_t);
> +    __uint(max_entries, 1);
> +} tap_rss_map_configurations SEC(".maps");
> +
> +struct {
> +    __uint(type, BPF_MAP_TYPE_ARRAY);
> +    __type(key, __u32);
> +    __type(value, struct toeplitz_key_data_t);
> +    __uint(max_entries, 1);
> +} tap_rss_map_toeplitz_key SEC(".maps");
> +
> +struct {
> +    __uint(type, BPF_MAP_TYPE_ARRAY);
> +    __type(key, __u32);
> +    __type(value, __u16);
> +    __uint(max_entries, INDIRECTION_TABLE_SIZE);
> +} tap_rss_map_indirection_table SEC(".maps");
> +
> +
> +static inline void net_rx_rss_add_chunk(__u8 *rss_input, size_t *bytes_written,
> +                                        const void *ptr, size_t size) {
> +    __builtin_memcpy(&rss_input[*bytes_written], ptr, size);
> +    *bytes_written += size;
> +}
> +
> +static inline
> +void net_toeplitz_add(__u32 *result,
> +                      __u8 *input,
> +                      __u32 len
> +        , struct toeplitz_key_data_t *key) {
> +
> +    __u32 accumulator = *result;
> +    __u32 leftmost_32_bits = key->leftmost_32_bits;
> +    __u32 byte;
> +
> +    for (byte = 0; byte < HASH_CALCULATION_BUFFER_SIZE; byte++) {
> +        __u8 input_byte = input[byte];
> +        __u8 key_byte = key->next_byte[byte];
> +        __u8 bit;
> +
> +        for (bit = 0; bit < 8; bit++) {
> +            if (input_byte & (1 << 7)) {
> +                accumulator ^= leftmost_32_bits;
> +            }
> +
> +            leftmost_32_bits =
> +                    (leftmost_32_bits << 1) | ((key_byte & (1 << 7)) >> 7);
> +
> +            input_byte <<= 1;
> +            key_byte <<= 1;
> +        }
> +    }
> +
> +    *result = accumulator;
> +}
> +
> +
> +static inline int ip6_extension_header_type(__u8 hdr_type)
> +{
> +    switch (hdr_type) {
> +    case IPPROTO_HOPOPTS:
> +    case IPPROTO_ROUTING:
> +    case IPPROTO_FRAGMENT:
> +    case IPPROTO_ICMPV6:
> +    case IPPROTO_NONE:
> +    case IPPROTO_DSTOPTS:
> +    case IPPROTO_MH:
> +        return 1;
> +    default:
> +        return 0;
> +    }
> +}
> +/*
> + * According to https://www.iana.org/assignments/ipv6-parameters/ipv6-parameters.xhtml
> + * we suspect that there are would be no more than 11 extensions in IPv6 header,
> + * also there is 27 TLV options for Destination and Hop-by-hop extensions.
> + * Need to choose reasonable amount of maximum extensions/options we may check to find
> + * ext src/dst.
> + */
> +#define IP6_EXTENSIONS_COUNT 11
> +#define IP6_OPTIONS_COUNT 30
> +
> +static inline void parse_ipv6_ext(struct __sk_buff *skb,
> +        struct packet_hash_info_t *info,
> +        __u8 *l4_protocol, size_t *l4_offset)
> +{
> +    if (!ip6_extension_header_type(*l4_protocol)) {
> +        return;
> +    }
> +
> +    struct ipv6_opt_hdr ext_hdr = {};
> +
> +    for (unsigned int i = 0; i < IP6_EXTENSIONS_COUNT; ++i) {
> +
> +        bpf_skb_load_bytes_relative(skb, *l4_offset, &ext_hdr,
> +                                    sizeof(ext_hdr), BPF_HDR_START_NET);
> +
> +        if (*l4_protocol == IPPROTO_ROUTING) {
> +            struct ipv6_rt_hdr ext_rt = {};
> +
> +            bpf_skb_load_bytes_relative(skb, *l4_offset, &ext_rt,
> +                                        sizeof(ext_rt), BPF_HDR_START_NET);
> +
> +            if ((ext_rt.type == IPV6_SRCRT_TYPE_2) &&
> +                    (ext_rt.hdrlen == sizeof(struct in6_addr) / 8) &&
> +                    (ext_rt.segments_left == 1)) {
> +
> +                bpf_skb_load_bytes_relative(skb,
> +                    *l4_offset + offsetof(struct rt2_hdr, addr),
> +                    &info->in6_ext_dst, sizeof(info->in6_ext_dst),
> +                    BPF_HDR_START_NET);
> +
> +                info->is_ipv6_ext_dst = 1;
> +            }
> +
> +        } else if (*l4_protocol == IPPROTO_DSTOPTS) {
> +            struct ipv6_opt_t {
> +                __u8 type;
> +                __u8 length;
> +            } __attribute__((packed)) opt = {};
> +
> +            size_t opt_offset = sizeof(ext_hdr);
> +
> +            for (unsigned int j = 0; j < IP6_OPTIONS_COUNT; ++j) {
> +                bpf_skb_load_bytes_relative(skb, *l4_offset + opt_offset,
> +                                        &opt, sizeof(opt), BPF_HDR_START_NET);
> +
> +                opt_offset += (opt.type == IPV6_TLV_PAD1) ?
> +                        1 : opt.length + sizeof(opt);
> +
> +                if (opt_offset + 1 >= ext_hdr.hdrlen * 8) {
> +                    break;
> +                }
> +
> +                if (opt.type == IPV6_TLV_HAO) {
> +                    bpf_skb_load_bytes_relative(skb,
> +                        *l4_offset + opt_offset + offsetof(struct ipv6_destopt_hao, addr),
> +                        &info->is_ipv6_ext_src, sizeof(info->is_ipv6_ext_src),
> +                        BPF_HDR_START_NET);
> +
> +                    info->is_ipv6_ext_src = 1;
> +                    break;
> +                }
> +            }
> +        }
> +
> +        *l4_protocol = ext_hdr.nexthdr;
> +        *l4_offset += (ext_hdr.hdrlen + 1) * 8;
> +
> +        if (!ip6_extension_header_type(ext_hdr.nexthdr)) {
> +            return;
> +        }
> +    }
> +}
> +
> +static inline void parse_packet(struct __sk_buff *skb,
> +        struct packet_hash_info_t *info)
> +{
> +    if (!info || !skb) {
> +        return;
> +    }
> +
> +    size_t l4_offset = 0;
> +    __u8 l4_protocol = 0;
> +    __u16 l3_protocol = __be16_to_cpu(skb->protocol);
> +
> +    if (l3_protocol == ETH_P_IP) {
> +        info->is_ipv4 = 1;
> +
> +        struct iphdr ip = {};
> +        bpf_skb_load_bytes_relative(skb, 0, &ip, sizeof(ip),
> +                                    BPF_HDR_START_NET);
> +
> +        info->in_src = ip.saddr;
> +        info->in_dst = ip.daddr;
> +
> +        l4_protocol = ip.protocol;
> +        l4_offset = ip.ihl * 4;
> +    } else if (l3_protocol == ETH_P_IPV6) {
> +        info->is_ipv6 = 1;
> +
> +        struct ipv6hdr ip6 = {};
> +        bpf_skb_load_bytes_relative(skb, 0, &ip6, sizeof(ip6),
> +                                    BPF_HDR_START_NET);
> +
> +        info->in6_src = ip6.saddr;
> +        info->in6_dst = ip6.daddr;
> +
> +        l4_protocol = ip6.nexthdr;
> +        l4_offset = sizeof(ip6);
> +
> +        parse_ipv6_ext(skb, info, &l4_protocol, &l4_offset);
> +    }
> +
> +    if (l4_protocol != 0) {
> +        if (l4_protocol == IPPROTO_TCP) {
> +            info->is_tcp = 1;
> +
> +            struct tcphdr tcp = {};
> +            bpf_skb_load_bytes_relative(skb, l4_offset, &tcp, sizeof(tcp),
> +                                        BPF_HDR_START_NET);
> +
> +            info->src_port = tcp.source;
> +            info->dst_port = tcp.dest;
> +        } else if (l4_protocol == IPPROTO_UDP) { /* TODO: add udplite? */
> +            info->is_udp = 1;
> +
> +            struct udphdr udp = {};
> +            bpf_skb_load_bytes_relative(skb, l4_offset, &udp, sizeof(udp),
> +                                        BPF_HDR_START_NET);
> +
> +            info->src_port = udp.source;
> +            info->dst_port = udp.dest;
> +        }
> +    }
> +}
> +
> +static inline __u32 calculate_rss_hash(struct __sk_buff *skb,
> +        struct rss_config_t *config, struct toeplitz_key_data_t *toe)
> +{
> +    __u8 rss_input[HASH_CALCULATION_BUFFER_SIZE] = {};
> +    size_t bytes_written = 0;
> +    __u32 result = 0;
> +    struct packet_hash_info_t packet_info = {};
> +
> +    parse_packet(skb, &packet_info);
> +
> +    if (packet_info.is_ipv4) {
> +        if (packet_info.is_tcp &&
> +            config->hash_types & VIRTIO_NET_RSS_HASH_TYPE_TCPv4) {
> +
> +            net_rx_rss_add_chunk(rss_input, &bytes_written,
> +                                 &packet_info.in_src,
> +                                 sizeof(packet_info.in_src));
> +            net_rx_rss_add_chunk(rss_input, &bytes_written,
> +                                 &packet_info.in_dst,
> +                                 sizeof(packet_info.in_dst));
> +            net_rx_rss_add_chunk(rss_input, &bytes_written,
> +                                 &packet_info.src_port,
> +                                 sizeof(packet_info.src_port));
> +            net_rx_rss_add_chunk(rss_input, &bytes_written,
> +                                 &packet_info.dst_port,
> +                                 sizeof(packet_info.dst_port));
> +        } else if (packet_info.is_udp &&
> +                   config->hash_types & VIRTIO_NET_RSS_HASH_TYPE_UDPv4) {
> +
> +            net_rx_rss_add_chunk(rss_input, &bytes_written,
> +                                 &packet_info.in_src,
> +                                 sizeof(packet_info.in_src));
> +            net_rx_rss_add_chunk(rss_input, &bytes_written,
> +                                 &packet_info.in_dst,
> +                                 sizeof(packet_info.in_dst));
> +            net_rx_rss_add_chunk(rss_input, &bytes_written,
> +                                 &packet_info.src_port,
> +                                 sizeof(packet_info.src_port));
> +            net_rx_rss_add_chunk(rss_input, &bytes_written,
> +                                 &packet_info.dst_port,
> +                                 sizeof(packet_info.dst_port));
> +        } else if (config->hash_types & VIRTIO_NET_RSS_HASH_TYPE_IPv4) {
> +            net_rx_rss_add_chunk(rss_input, &bytes_written,
> +                                 &packet_info.in_src,
> +                                 sizeof(packet_info.in_src));
> +            net_rx_rss_add_chunk(rss_input, &bytes_written,
> +                                 &packet_info.in_dst,
> +                                 sizeof(packet_info.in_dst));
> +        }
> +    } else if (packet_info.is_ipv6) {
> +        if (packet_info.is_tcp &&
> +            config->hash_types & VIRTIO_NET_RSS_HASH_TYPE_TCPv6) {
> +
> +            if (packet_info.is_ipv6_ext_src &&
> +                config->hash_types & VIRTIO_NET_RSS_HASH_TYPE_TCP_EX) {
> +
> +                net_rx_rss_add_chunk(rss_input, &bytes_written,
> +                                     &packet_info.in6_ext_src,
> +                                     sizeof(packet_info.in6_ext_src));
> +            } else {
> +                net_rx_rss_add_chunk(rss_input, &bytes_written,
> +                                     &packet_info.in6_src,
> +                                     sizeof(packet_info.in6_src));
> +            }
> +            if (packet_info.is_ipv6_ext_dst &&
> +                config->hash_types & VIRTIO_NET_RSS_HASH_TYPE_TCP_EX) {
> +
> +                net_rx_rss_add_chunk(rss_input, &bytes_written,
> +                                     &packet_info.in6_ext_dst,
> +                                     sizeof(packet_info.in6_ext_dst));
> +            } else {
> +                net_rx_rss_add_chunk(rss_input, &bytes_written,
> +                                     &packet_info.in6_dst,
> +                                     sizeof(packet_info.in6_dst));
> +            }
> +            net_rx_rss_add_chunk(rss_input, &bytes_written,
> +                                 &packet_info.src_port,
> +                                 sizeof(packet_info.src_port));
> +            net_rx_rss_add_chunk(rss_input, &bytes_written,
> +                                 &packet_info.dst_port,
> +                                 sizeof(packet_info.dst_port));
> +        } else if (packet_info.is_udp &&
> +                   config->hash_types & VIRTIO_NET_RSS_HASH_TYPE_UDPv6) {
> +
> +            if (packet_info.is_ipv6_ext_src &&
> +               config->hash_types & VIRTIO_NET_RSS_HASH_TYPE_UDP_EX) {
> +
> +                net_rx_rss_add_chunk(rss_input, &bytes_written,
> +                                     &packet_info.in6_ext_src,
> +                                     sizeof(packet_info.in6_ext_src));
> +            } else {
> +                net_rx_rss_add_chunk(rss_input, &bytes_written,
> +                                     &packet_info.in6_src,
> +                                     sizeof(packet_info.in6_src));
> +            }
> +            if (packet_info.is_ipv6_ext_dst &&
> +               config->hash_types & VIRTIO_NET_RSS_HASH_TYPE_UDP_EX) {
> +
> +                net_rx_rss_add_chunk(rss_input, &bytes_written,
> +                                     &packet_info.in6_ext_dst,
> +                                     sizeof(packet_info.in6_ext_dst));
> +            } else {
> +                net_rx_rss_add_chunk(rss_input, &bytes_written,
> +                                     &packet_info.in6_dst,
> +                                     sizeof(packet_info.in6_dst));
> +            }
> +
> +            net_rx_rss_add_chunk(rss_input, &bytes_written,
> +                                 &packet_info.src_port,
> +                                 sizeof(packet_info.src_port));
> +            net_rx_rss_add_chunk(rss_input, &bytes_written,
> +                                 &packet_info.dst_port,
> +                                 sizeof(packet_info.dst_port));
> +
> +        } else if (config->hash_types & VIRTIO_NET_RSS_HASH_TYPE_IPv6) {
> +            if (packet_info.is_ipv6_ext_src &&
> +               config->hash_types & VIRTIO_NET_RSS_HASH_TYPE_IP_EX) {
> +
> +                net_rx_rss_add_chunk(rss_input, &bytes_written,
> +                                     &packet_info.in6_ext_src,
> +                                     sizeof(packet_info.in6_ext_src));
> +            } else {
> +                net_rx_rss_add_chunk(rss_input, &bytes_written,
> +                                     &packet_info.in6_src,
> +                                     sizeof(packet_info.in6_src));
> +            }
> +            if (packet_info.is_ipv6_ext_dst &&
> +                config->hash_types & VIRTIO_NET_RSS_HASH_TYPE_IP_EX) {
> +
> +                net_rx_rss_add_chunk(rss_input, &bytes_written,
> +                                     &packet_info.in6_ext_dst,
> +                                     sizeof(packet_info.in6_ext_dst));
> +            } else {
> +                net_rx_rss_add_chunk(rss_input, &bytes_written,
> +                                     &packet_info.in6_dst,
> +                                     sizeof(packet_info.in6_dst));
> +            }
> +        }
> +    }
> +
> +    if (bytes_written) {
> +        net_toeplitz_add(&result, rss_input, bytes_written, toe);
> +    }
> +
> +    return result;
> +}
> +
> +SEC("tun_rss_steering")
> +int tun_rss_steering_prog(struct __sk_buff *skb)
> +{
> +
> +    struct rss_config_t *config = 0;
> +    struct toeplitz_key_data_t *toe = 0;
> +
> +    __u32 key = 0;
> +    __u32 hash = 0;
> +
> +    config = bpf_map_lookup_elem(&tap_rss_map_configurations, &key);
> +    toe = bpf_map_lookup_elem(&tap_rss_map_toeplitz_key, &key);
> +
> +    if (config && toe) {
> +        if (!config->redirect) {
> +            return config->default_queue;
> +        }
> +
> +        hash = calculate_rss_hash(skb, config, toe);
> +        if (hash) {
> +            __u32 table_idx = hash % config->indirections_len;
> +            __u16 *queue = 0;
> +
> +            queue = bpf_map_lookup_elem(&tap_rss_map_indirection_table,
> +                                        &table_idx);
> +
> +            if (queue) {
> +                return *queue;
> +            }
> +        }
> +
> +        return config->default_queue;
> +    }
> +
> +    return -1;
> +}
> +
> +char _license[] SEC("license") = "GPL";

This doesn't specify any GPL version


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


